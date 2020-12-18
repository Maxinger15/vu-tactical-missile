
local mortarPartitionGuid = Guid('168F529B-17F6-11E0-8CD8-85483A75A7C5')
local customBlueprintGuid = Guid('D407033B-49AE-DF14-FE19-FC776AE04E2C')
NetEvents:Subscribe('vu-tactical-missile:Launch', function(player, position)

	position.y = position.y + 200

	local launchTransform = LinearTransform(
		Vec3(0,  0, -1),
		Vec3(1,  0,  0),
		Vec3(0, -1,  0),
		position
	)

	local params = EntityCreationParams()
	params.transform = launchTransform
	params.networked = true

	local blueprint = ResourceManager:FindInstanceByGuid(mortarPartitionGuid,customBlueprintGuid)
	--blueprint:MakeWritable()
	--data = MissileEntityData(blueprint.object)
	--data:MakeWritable()
	--data.defaultTeam = player.teamId
	--blueprint.object = data
	local projectileEntityBus = EntityBus(EntityManager:CreateEntitiesFromBlueprint(blueprint, params))
	print(player.teamId)
	for _,entity in pairs(projectileEntityBus.entities) do
			entity:Init(Realm.Realm_ClientAndServer, true)
			print(entity.typeInfo.name)
	end
end)

--Hooks:Install('Soldier:Damage', 100, function(hook, soldier, info, giverInfo)
	
--	print(soldier.player.name)
--	print(soldier.player.teamId)
--	print("giver")
--	print(giverInfo.weaponFiring.typeInfo.name)
--	hook:Return()
	
    -- Do stuff here.
--end)