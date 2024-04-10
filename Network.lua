--!strict

export type RemoteType = "Callable" | "Invokable" | "UnreliableCallable"

type Remote = RemoteEvent | RemoteFunction | UnreliableRemoteEvent

local RemoteTypeClasses: {
	[RemoteType]: string
} = table.freeze {
	["Callable"] = "RemoteEvent",
	["Invokable"] = "RemoteFunction",
	["UnreliableCallable"] = "UnreliableRemoteEvent"
}

type Network = {
	["Remotes"]: {
		[string]: Remote
	},
	["Reserve"]: (Network, string, RemoteType) -> Remote,
	["Create"]: (Network, string, RemoteType) -> Remote,
	["Destroy"]: (Network, string) -> boolean
}

return table.freeze {
	
	["Remotes"] = {},

	["Reserve"] = function(self: Network, name: string, remoteType: RemoteType): Remote
		local existingRemote: Remote = self.Remotes[name]
		if existingRemote then
			assert(existingRemote:IsA(RemoteTypeClasses[remoteType]), "A remote of a different type with that name is already in use")
		end

		local remoteInstance: Remote = self:Create(name, remoteType)
		self.Remotes[name] = remoteInstance
		return remoteInstance
	end,

	["Create"] = function(self: Network, name: string, remoteType: RemoteType): Remote
		local remoteInstance: Instance = Instance.new(RemoteTypeClasses[remoteType])
		remoteInstance.Name = name
		return remoteInstance :: Remote
	end,

	["Destroy"] = function(self: Network, name: string): boolean
		local existingRemote: Remote = self.Remotes[name]
		if not existingRemote then
			return false
		end
		existingRemote:Destroy()
		return true
	end,
	
} :: Network
