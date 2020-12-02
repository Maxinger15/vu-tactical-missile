local blastImpulseModifier = 100
local blastDamageModifier = 2000
local blastRadiusModifier = 100
local innerBlastRadiusModifier = 60
local shockWaveImpulseModifier = 50
local shockwaveRadiusModifier = 20
local shockwaveTimeModifier = 7
local cameraShockwaveRadiusModifier = 20
local maxOcclusionRaycastRadiusModifier = 3
local sizeMultiplier = 5
local tvExplosion = nil

ResourceManager:RegisterInstanceLoadHandler(Guid('1DF6F9A2-8BA1-11E0-9EF7-9C4CA6DBFDF3'), Guid('360168D5-1442-42BA-A158-56CEEC950AE4'), function(instance)

    local tvVehicleConfig = VehicleConfigData(instance)
    tvVehicleConfig:MakeWritable()
    tvVehicleConfig.vehicleModeAtReset = VehicleMode.VmStarted
    tvVehicleConfig.motionDamping = nil
end)

ResourceManager:RegisterInstanceLoadHandler(Guid('1DF6F9A2-8BA1-11E0-9EF7-9C4CA6DBFDF3'), Guid('865D93BF-5382-40D5-882B-6E61F36EF6B0'), function(instance)

    local tvGearboxConfig = GearboxConfigData(instance)
    tvGearboxConfig:MakeWritable()
    tvGearboxConfig.forwardGearSpeeds[1] = 150
end)

ResourceManager:RegisterInstanceLoadHandler(Guid('1DF6F9A2-8BA1-11E0-9EF7-9C4CA6DBFDF3'), Guid('54A39570-E8D8-4A5F-8CFC-118E10F9732A'), function(instance)

    local engine = JetEngineConfigData(instance)
    engine:MakeWritable()
    engine.maxVelocity = 350
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

ResourceManager:RegisterInstanceLoadHandler(Guid('1DF6F9A2-8BA1-11E0-9EF7-9C4CA6DBFDF3'), Guid('37024431-B930-48AB-9BD9-465AEFF3537D'), function(instance)
    chassis2 = EffectComponentData(instance)
   
end)

ResourceManager:RegisterInstanceLoadHandler(Guid('1DF6F9A2-8BA1-11E0-9EF7-9C4CA6DBFDF3'), Guid('D8486FE8-ABF1-45B7-822A-41C4F492CF77'), function(instance)

    tvExplosion = VeniceExplosionEntityData(instance)
    tvExplosion:MakeWritable()
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