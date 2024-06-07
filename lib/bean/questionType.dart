// { label: "未分类", value: "0" },
// { label: "通知问题", value: "1" },
// { label: "配网问题", value: "2" },
// { label: "拉流问题", value: "3" },
// { label: "网络问题", value: "4" },
// { label: "设备问题", value: "5" },
// { label: "崩溃问题", value: "6" },
// { label: "需求性问题", value: "7" },
// { label: "适配问题", value: "8" },
// { label: "兼容性问题", value: "9" },
// { label: "后台音频问题", value: "10" },
// { label: "非问题", value: "11" },
// { label: "其他", value: "12" }

String typeString(String type) {
  switch (type) {
    case "0":
      return '未分类';
    case "1":
      return '通知问题';
    case "2":
      return '配网问题';
    case "3":
      return '拉流问题';
    case "4":
      return '网络问题';
    case "5":
      return '设备问题';
    case "6":
      return '崩溃问题';
    case "7":
      return '需求性问题';
    case "8":
      return '适配问题';
    case "9":
      return '兼容性问题';
    case "10":
      return '后台音频问题';
    case "11":
      return '非问题';
    case "12":
      return '其他';
    default:
      return '未分类';
  }
}

int versionToCode(String type) {
  switch (type) {
    case "1.0.6":
      return 6;
    case "1.0.7":
      return 7;
    case "1.0.8":
      return 8;
    case "1.0.9":
      return 9;
    case "1.1.0":
      return 10;
    case "1.1.1":
      return 11;
    case "1.2.0":
      return 12;
    case "1.2.1":
      return 13;
    default:
      return 14;
  }
}
