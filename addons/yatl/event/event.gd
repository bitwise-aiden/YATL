extends Resource


# Private imports

const __PAL: Resource = preload("../pal/pal.gd")


# Public imports

const ChannelBanEvent: Resource = preload("./types/events.gd").ChannelBanEvent
const ChannelSubscribeEvent: Resource = preload("./types/events.gd").ChannelSubscribeEvent
const ChannelCheerEvent: Resource = preload("./types/events.gd").ChannelCheerEvent
const ChannelUpdateEvent: Resource = preload("./types/events.gd").ChannelUpdateEvent
const ChannelUnbanEvent: Resource = preload("./types/events.gd").ChannelUnbanEvent
const ChannelFollowEvent: Resource = preload("./types/events.gd").ChannelFollowEvent
const ChannelRaidEvent: Resource = preload("./types/events.gd").ChannelRaidEvent
const ChannelModeratorAddEvent: Resource = preload("./types/events.gd").ChannelModeratorAddEvent
const ChannelModeratorRemoveEvent: Resource = preload("./types/events.gd").ChannelModeratorRemoveEvent
const ChannelPollBeginEvent: Resource = preload("./types/events.gd").ChannelPollBeginEvent
const ChannelPollProgressEvent: Resource = preload("./types/events.gd").ChannelPollProgressEvent
const ChannelPollEndEvent: Resource = preload("./types/events.gd").ChannelPollEndEvent
const ChannelPointsCustomRewardAddEvent: Resource = preload("./types/events.gd").ChannelPointsCustomRewardAddEvent
const ChannelPointsCustomRewardUpdateEvent: Resource = preload("./types/events.gd").ChannelPointsCustomRewardUpdateEvent
const ChannelPointsCustomRewardRemoveEvent: Resource = preload("./types/events.gd").ChannelPointsCustomRewardRemoveEvent
const ChannelPointsCustomRewardRedemptionAddEvent: Resource = preload("./types/events.gd").ChannelPointsCustomRewardRedemptionAddEvent
const ChannelPointsCustomRewardRedemptionUpdateEvent: Resource = preload("./types/events.gd").ChannelPointsCustomRewardRedemptionUpdateEvent
const ChannelPredictionBeginEvent: Resource = preload("./types/events.gd").ChannelPredictionBeginEvent
const ChannelPredictionProgressEvent: Resource = preload("./types/events.gd").ChannelPredictionProgressEvent
const ChannelPredictionLockEvent: Resource = preload("./types/events.gd").ChannelPredictionLockEvent
const ChannelPredictionEndEvent: Resource = preload("./types/events.gd").ChannelPredictionEndEvent
const ChannelSubscriptionEndEvent: Resource = preload("./types/events.gd").ChannelSubscriptionEndEvent
const ChannelSubscriptionGiftEvent: Resource = preload("./types/events.gd").ChannelSubscriptionGiftEvent
const ChannelSubscriptionMessageEvent: Resource = preload("./types/events.gd").ChannelSubscriptionMessageEvent
const DropEntitlementGrantEvent: Resource = preload("./types/events.gd").DropEntitlementGrantEvent
const ExtensionBitsTransactionCreateEvent: Resource = preload("./types/events.gd").ExtensionBitsTransactionCreateEvent
const GoalsEvent: Resource = preload("./types/events.gd").GoalsEvent
const HypeTrainBeginEvent: Resource = preload("./types/events.gd").HypeTrainBeginEvent
const HypeTrainProgressEvent: Resource = preload("./types/events.gd").HypeTrainProgressEvent
const HypeTrainEndEvent: Resource = preload("./types/events.gd").HypeTrainEndEvent
const StreamOnlineEvent: Resource = preload("./types/events.gd").StreamOnlineEvent
const StreamOfflineEvent: Resource = preload("./types/events.gd").StreamOfflineEvent
const UserAuthorizationGrantEvent: Resource = preload("./types/events.gd").UserAuthorizationGrantEvent
const UserAuthorizationRevokeEvent: Resource = preload("./types/events.gd").UserAuthorizationRevokeEvent
const UserUpdateEvent: Resource = preload("./types/events.gd").UserUpdateEvent
