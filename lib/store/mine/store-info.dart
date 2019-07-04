import 'package:mobx/mobx.dart';

part 'store-info.g.dart';

class StoreInfoStore = _StoreInfoStore with _$StoreInfoStore;

abstract class _StoreInfoStore with Store {
  int id;
  String code;
  int parentId;
  String name;
  String alias;
  String contactName;
  String contactTel;
  String address;
  @observable
  int deliveryFee;
  @observable
  int freeDlvLimit;
  int sellerId;
  int shareRate;
  int shareEndDate;
  int deliveryDate;
  int operatorId;
  String operatorName;
  int type;
  int createTime;
  int updateTime;

  _StoreInfoStore(
    {this.id,
      this.code,
      this.parentId,
      this.name,
      this.alias,
      this.contactName,
      this.contactTel,
      this.address,
      this.deliveryFee,
      this.freeDlvLimit,
      this.sellerId,
      this.shareRate,
      this.shareEndDate,
      this.deliveryDate,
      this.operatorId,
      this.operatorName,
      this.type,
      this.createTime,
      this.updateTime}
  );

  _StoreInfoStore.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    parentId = json['parentId'];
    name = json['name'];
    alias = json['alias'];
    contactName = json['contactName'];
    contactTel = json['contactTel'];
    address = json['address'];
    deliveryFee = json['deliveryFee'];
    freeDlvLimit = json['freeDlvLimit'];
    sellerId = json['sellerId'];
    shareRate = json['shareRate'];
    shareEndDate = json['shareEndDate'];
    deliveryDate = json['deliveryDate'];
    operatorId = json['operatorId'];
    operatorName = json['operatorName'];
    type = json['type'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
  }
}