class ChannelItem {
  String type;
  String desc;

  ChannelItem({this.type, this.desc});
}

List<ChannelItem> _payChannels = [
  ChannelItem(type: 'pc-1', desc: '支付宝'),
  ChannelItem(type: 'pc-2', desc: '微信'),
  ChannelItem(type: 'pc-3', desc: '现金'),
  ChannelItem(type: 'pc-4', desc: '其他')
];

class PayChannels {
  static List<ChannelItem> payChannels = _payChannels;
}

