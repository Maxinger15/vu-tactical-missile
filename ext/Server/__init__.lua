
local mortarPartitionGuid = Guid('5350B268-18C9-11E0-B820-CD6C272E4FCC')
local customBlueprintGuid = Guid('D407033B-49AE-DF14-FE19-FC776AE04E2C')
NetEvents:Subscribe('vu-tactical-missile:Launch', function(player, position)

	position.y = position.y + 650

	local launchTransform = LinearTransform(
		Vec3(0,  0, -1),
		Vec3(1,  0,  0),
		Vec3(0, -1,  0),
		position
	)

	local params = EntityCreationParams()
	params.transform = launchTransform
	params.networked = true

	local blueprint = VehicleBlueprint(ResourceManager:SearchForDataContainer("Vehicles/common/WeaponData/AGM-144_Hellfire_TV"))
	blueprint:MakeWritable()
	data = VehicleEntityData(blueprint.object)
	data:MakeWritable()
	data.resetTeamOnLastPlayerExits = false
	blueprint.object = data
	local projectileEntityBus = EntityBus(EntityManager:CreateEntitiesFromBlueprint(blueprint, params))
	print(player.teamId)
	for _,entity in pairs(projectileEntityBus.entities) do
			entity:Init(Realm.Realm_ClientAndServer, true)
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