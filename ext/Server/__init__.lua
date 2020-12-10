
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

	local projectileEntityBus = EntityBus(EntityManager:CreateEntitiesFromBlueprint(blueprint, params))

	for _,entity in pairs(projectileEntityBus.entities) do
		entity = Entity(entity)
		entity:Init(Realm.Realm_ClientAndServer, true)
	end
end)