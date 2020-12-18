local blastImpulseModifier = 100
local blastDamageModifier = 2000
local blastRadiusModifier = 100
local innerBlastRadiusModifier = 60
local shockWaveImpulseModifier = 50
local shockwaveRadiusModifier = 20
local shockwaveTimeModifier = 7
local cameraShockwaveRadiusModifier = 20
local maxOcclusionRaycastRadiusModifier = 3
local sizeMultiplier = 6
local tvExplosion = nil

local effectMulti = 50

local m_UpdateAgeDataGuid = Guid("C38909B9-4E56-42A9-9E42-D28DB07EE592")
local m_SphereEvaluatorDataGuid = Guid("8A18AF83-CFFE-4449-9EBF-EB0564D37D78")
local m_SpawnRateDataGuid = Guid("B71F0B44-5057-4D51-ADFC-A2247F82821C")

local m_NewExplosionEffect = Guid("1778F5B2-770C-4A90-9C3A-FEEEE3E341FC")

--Events:Subscribe('BundleMounter:GetBundles', function(bundles)
--   Events:Dispatch('BundleMounter:LoadBundles', 'levels/xp3_desert/xp3_desert', {
--    "levels/xp3_desert/xp3_desert",
--    "levels/xp3_desert/conquestlarge0",
--    "levels/xp3_desert/xp3_desert_gameconfiglight_win32",
--    "levels/xp3_desert/xp3_desert_settings_win32",
--  })
-- end)


--Events:Subscribe('BundleMounter:GetBundles', function(bundles)
    --Events:Dispatch('BundleMounter:LoadBundles', 'FX/Vehicles/VehiclesDestruction/Explosions/FX_explosion_AirDroppedBomb_01', {
      --'FX/Vehicles/VehiclesDestruction/Explosions/FX_explosion_AirDroppedBomb_01',
  --})
--end)

ResourceManager:RegisterInstanceLoadHandler(Guid('1DF6F9A2-8BA1-11E0-9EF7-9C4CA6DBFDF3'), Guid('360168D5-1442-42BA-A158-56CEEC950AE4'), function(instance)
    partition = ResourceManager:FindDatabasePartition(Guid('99BBD45B-963F-11DE-BE9A-A709424EAFF7'))
    print(partition.name)
    local tvVehicleConfig = VehicleConfigData(instance)
    tvVehicleConfig:MakeWritable()
    tvVehicleConfig.vehicleModeAtReset = VehicleMode.VmStarted
    tvVehicleConfig.motionDamping = nil
end)

ResourceManager:RegisterInstanceLoadHandler(Guid('1DF6F9A2-8BA1-11E0-9EF7-9C4CA6DBFDF3'), Guid('865D93BF-5382-40D5-882B-6E61F36EF6B0'), function(instance)

    local tvGearboxConfig = GearboxConfigData(instance)
    tvGearboxConfig:MakeWritable()
    tvGearboxConfig.forwardGearSpeeds[1] = 140
end)

ResourceManager:RegisterInstanceLoadHandler(Guid('1DF6F9A2-8BA1-11E0-9EF7-9C4CA6DBFDF3'), Guid('54A39570-E8D8-4A5F-8CFC-118E10F9732A'), function(instance)

    local engine = JetEngineConfigData(instance)
    engine:MakeWritable()
    engine.maxVelocity = 330
end)

ResourceManager:RegisterInstanceLoadHandler(Guid('1DF6F9A2-8BA1-11E0-9EF7-9C4CA6DBFDF3'), Guid('17E40C22-C16E-B653-B808-A8B3D8AE4D67'), function(instance)
    local asset = HavokAsset(instance)
    asset:MakeWritable()
    asset.scale = sizeMultiplier
end)
ResourceManager:RegisterInstanceLoadHandler(Guid('1DF6F9A2-8BA1-11E0-9EF7-9C4CA6DBFDF3'), Guid('F2BF8B55-6288-F12E-40D1-B566E782FCBD'), function(instance)
    local chassis = ChassisComponentData(instance)
    chassis:MakeWritable()
    chassis.transform =  LinearTransform(
        Vec3(sizeMultiplier, 0, 0),
        Vec3(0, sizeMultiplier, 0),
        Vec3(0, 0, sizeMultiplier),
        Vec3(0,0,0))
end)

ResourceManager:RegisterInstanceLoadHandler(Guid('1DF6F9A2-8BA1-11E0-9EF7-9C4CA6DBFDF3'), Guid('FA54904C-FE9C-4F26-AC7A-71CD94A43442'), function(instance)
    chassis1 = EffectComponentData(instance)
    chassis1:MakeWritable()
   chassis1.transform = LinearTransform(
		 Vec3(sizeMultiplier, 0, 0),
		 Vec3(0, sizeMultiplier, 0),
		 Vec3(0, 0, sizeMultiplier),
		 Vec3(0,0,0))
end)


ResourceManager:RegisterInstanceLoadHandler(Guid('1DF6F9A2-8BA1-11E0-9EF7-9C4CA6DBFDF3'), Guid('D8486FE8-ABF1-45B7-822A-41C4F492CF77'), function(instance)

    tvExplosion = VeniceExplosionEntityData(instance)
    tvExplosion:MakeWritable()
    tvExplosion.detonationEffect = EffectBlueprint(ResourceManager:FindInstanceByGuid(Guid("CEA6C2B6-77D9-11E0-A0DF-97916043AD3E"),Guid("06990B51-5E47-6158-4F01-130DF1101EC1")))
    print(tostring(tvExplosion.detonationEffect.typeInfo.name))
    tvExplosion.blastImpulse = tvExplosion.blastImpulse * blastImpulseModifier
    tvExplosion.blastRadius = tvExplosion.blastRadius * blastRadiusModifier
    tvExplosion.innerBlastRadius = tvExplosion.innerBlastRadius * innerBlastRadiusModifier
    tvExplosion.shockwaveImpulse = tvExplosion.shockwaveImpulse * shockWaveImpulseModifier
    tvExplosion.shockwaveRadius = tvExplosion.shockwaveRadius * shockwaveRadiusModifier
    tvExplosion.shockwaveTime = tvExplosion.shockwaveTime * shockwaveTimeModifier
    tvExplosion.cameraShockwaveRadius = tvExplosion.cameraShockwaveRadius * cameraShockwaveRadiusModifier
    tvExplosion.maxOcclusionRaycastRadius =  maxOcclusionRaycastRadiusModifier
    tvExplosion.blastDamage = blastDamageModifier
    tvExplosion.isCausingSuppression = true
    tvExplosion.showOnMinimap = true
    --tvExplosion.transform = LinearTransform(
	--	 Vec3(4000, 0, 0),
	--	 Vec3(0, 4000, 0),
	--	 Vec3(0, 0, 4000),
	--	 Vec3(0,0,0))
    --tvExplosion.useEntityTransformForDetonationEffect = true
    print("blastImpulseModifier = "..tostring(blastImpulseModifier))
    print("blastRadiusModifier = "..tostring(blastRadiusModifier))
    print("innerBlastRadiusModifier = "..tostring(innerBlastRadiusModifier))
    print("shockWaveImpulseModifier = "..tostring(shockWaveImpulseModifier))
    print("shockwaveRadiusModifier = "..tostring(shockwaveRadiusModifier))
    print("shockwaveTimeModifier = "..tostring(shockwaveTimeModifier))
    print("cameraShockwaveRadiusModifier = "..tostring(cameraShockwaveRadiusModifier))
end)


