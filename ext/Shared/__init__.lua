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

local tvPartitionGuid = Guid('168F529B-17F6-11E0-8CD8-85483A75A7C5')

local customBlueprintGuid = Guid('D407033B-49AE-DF14-FE19-FC776AE04E2C')
local customProjectileDataGuid = Guid('81E0126A-8452-AEC6-5E4E-94A72DBBB964')
local customExplosionDataGuid = Guid('6B1E1B5F-2487-2511-A0D4-39262CFC74B5')
local customHavokAsset = Guid("99578AFB-A37E-4AB7-8CB1-EC3EE1ED045E")


Events:Subscribe('Partition:Loaded', function(partition)

    if partition.guid ~= tvPartitionGuid then
        return
    end

    local mortarBlueprint = partition.primaryInstance

    local artyProjectileBlueprint = ProjectileBlueprint(mortarBlueprint:Clone(customBlueprintGuid))
    local artyProjectileData = MissileEntityData(artyProjectileBlueprint.object:Clone(customProjectileDataGuid))
    local artyExplosionData = ExplosionEntityData(artyProjectileData.explosion:Clone(customExplosionDataGuid))
   --local havocAsset = HavokAsset(artyProjectileData)
    --artyExplosionData.detonationEffect = EffectBlueprint(ResourceManager:FindInstanceByGuid(Guid("CEA6C2B6-77D9-11E0-A0DF-97916043AD3E"),Guid("06990B51-5E47-6158-4F01-130DF1101EC1")))
    
    artyProjectileData.maxSpeed = 14000
    artyProjectileData.initialSpeed = 900
    artyProjectileData.engineStrength = 150
    artyProjectileData.gravity = -10.5
    artyProjectileData.explosion = artyExplosionData

    artyProjectileBlueprint.object = artyProjectileData
    
    artyProjectileData.explosion.blastDamage = 75
    artyProjectileData.explosion.blastRadius = 13
    artyProjectileData.explosion.innerBlastRadius = 7
    artyProjectileData.explosion.shockwaveRadius = 30
    artyProjectileData.explosion.shockwaveImpulse = 800
    artyProjectileData.explosion.shockwaveTime = 0.6
    artyProjectileData.explosion.hasStunEffect = true
    partition:AddInstance(artyProjectileBlueprint)
    partition:AddInstance(artyProjectileData)
    partition:AddInstance(artyExplosionData)

    print("instances cloned")
end)

Events:Subscribe('Level:RegisterEntityResources', function(levelData)
 
    local partition = ResourceManager:FindDatabasePartition(tvPartitionGuid)

    local artyProjectileBlueprint = ProjectileBlueprint(partition:FindInstance(customBlueprintGuid))
    local artyProjectileData = ProjectileEntityData(partition:FindInstance(customProjectileDataGuid))
    local artyExplosionData = ExplosionEntityData(partition:FindInstance(customExplosionDataGuid))

    local registry = RegistryContainer()
    registry.blueprintRegistry:add(artyProjectileBlueprint)
    registry.entityRegistry:add(artyProjectileData)
    registry.entityRegistry:add(artyExplosionData)

    ResourceManager:AddRegistry(registry, ResourceCompartment.ResourceCompartment_Game)

    print("registry added")
end)