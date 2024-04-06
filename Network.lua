--!strict

export type NetworkRemoteType = "Callable" | "Invokable"
type Remote = RemoteEvent | RemoteFunction

type Network = {
	["Remotes"]: {
		[string]: Remote
	},
	["Reserve"]: (Network, string, NetworkRemoteType) -> Remote,
	["Create"]: (Network, string, NetworkRemoteType) -> Remote,
	["Destroy"]: (Network, string) -> boolean
}

local Network: Network = {
	["Remotes"] = {},

	["Reserve"] = function(self: Network, name: string, remoteType: NetworkRemoteType): Remote
		local existingRemote: Remote = self.Remotes[name]
		if existingRemote then
			if remoteType == "Callable" then
				assert(typeof(existingRemote) == "RemoteFunction", "A callable remote with that name is already in use")
			else
				assert(typeof(existingRemote) == "RemoteEvent", "An invokable remote with that name is already in use")
			end
			return existingRemote
		end

		local remoteInstance: Remote = self:Create(name, remoteType)
		self.Remotes[name] = remoteInstance
		return remoteInstance
	end,

	["Create"] = function(self: Network,name: string, remoteType: NetworkRemoteType): Remote
		local remoteInstance: Instance = Instance.new(if remoteType == "Callable" then "RemoteEvent" else "RemoteFunction")
		remoteInstance.Name = name
		return remoteInstance :: Remote
	end,

	["Destroy"] = function(self: Network,name: string): boolean
		local existingRemote: Remote = self.Remotes[name]
		if not existingRemote then
			return false
		end
		existingRemote:Destroy()
		return true
	end
}

return setmetatable(Network, {
	__call = Network.Reserve
})
