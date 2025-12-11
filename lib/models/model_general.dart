//--------------------------------------------------------------------------------- location
// lib/models/model_general.dart

//--------------------------------------------------------------------------------- Description
// This is model for general

//--------------------------------------------------------------------------------- Import

//--------------------------------------------------------------------------------- Model
//--------------------------------[model_way_item]
class model_way_item {
  bool enable;
  Map<String, bool> routes;
  model_way_item({this.enable = false, this.routes = const {}});
  Map<String, dynamic> toJson() => {'enable': enable, 'routes': routes};
  factory model_way_item.toModel(Map<String, dynamic> json) => model_way_item(enable: json['enable'], routes: Map<String, bool>.from(json['routes']));
}

//--------------------------------[model_network_item]
class model_network_item {
  bool enable;
  Map<String, model_way_item> ways;
  model_network_item({this.enable = false, this.ways = const {}});
  Map<String, dynamic> toJson() => {'enable': enable, 'ways': ways.map((key, way) => MapEntry(key, way.toJson()))};
  factory model_network_item.toModel(Map<String, dynamic> json) {
    return model_network_item(
      enable: json['enable'],
      ways: Map<String, model_way_item>.from((json['ways'] as Map).map((key, value) => MapEntry(key.toString(), model_way_item.toModel(value)))),
    );
  }
}

//--------------------------------[model_inbound_item]
class model_inbound_item {
  bool display;
  bool enable;
  model_inbound_item({this.display = false, this.enable = false});
  Map<String, dynamic> toJson() => {'display': display, 'enable': enable};
  factory model_inbound_item.toModel(Map<String, dynamic> json) => model_inbound_item(display: json['display'], enable: json['enable']);
}

//--------------------------------[model_service_v2ray_item]
class model_service_v2ray_item {
  Map<String, model_inbound_item> inbounds;
  Map<String, model_network_item> networks;
  model_service_v2ray_item({this.inbounds = const {}, this.networks = const {}});
  Map<String, dynamic> toJson() => {'inbounds': inbounds.map((key, item) => MapEntry(key, item.toJson())), 'networks': networks.map((key, item) => MapEntry(key, item.toJson()))};
  factory model_service_v2ray_item.toModel(Map<String, dynamic> json) {
    return model_service_v2ray_item(
      inbounds: Map<String, model_inbound_item>.from((json['inbounds'] as Map).map((key, value) => MapEntry(key.toString(), model_inbound_item.toModel(value)))),
      networks: Map<String, model_network_item>.from((json['networks'] as Map).map((key, value) => MapEntry(key.toString(), model_network_item.toModel(value)))),
    );
  }
}

//--------------------------------[model_service_openvpn_item]
class model_service_openvpn_item {
  int id;
  String? name;
  bool enable;

  model_service_openvpn_item({this.id = 1, this.name, this.enable = false});

  factory model_service_openvpn_item.fromJson(Map<String, dynamic> json) {
    return model_service_openvpn_item(id: json['id'] ?? 1, name: json['name'], enable: json['enable'] ?? false);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'enable': enable};
  }
}
