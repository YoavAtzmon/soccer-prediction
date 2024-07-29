class LeagueProps {
  String name;
  bool withAccessCode;
  Payment payment;

  LeagueProps({
    required this.name,
    required this.withAccessCode,
    required this.payment,
  });
  factory LeagueProps.fromMap(Map<String, dynamic> map) {
    return LeagueProps(
      name: map['name'] as String,
      withAccessCode: (map['withAccessCode'] ?? false) as bool,
      payment: (map['withPay'] ?? false) as bool
          ? PaymentWithPay(map['paymentLink'] as String)
          : PaymentWithoutPay(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'withAccessCode': withAccessCode,
      'payment': payment.toJson(),
    };
  }
}

abstract class Payment {
  Map<String, dynamic> toJson();
}

class PaymentWithPay extends Payment {
  String paymentLink;
  PaymentWithPay(this.paymentLink);

  @override
  Map<String, dynamic> toJson() {
    return {
      'withPay': true,
      'paymentLink': paymentLink,
    };
  }
}

class PaymentWithoutPay extends Payment {
  @override
  Map<String, dynamic> toJson() {
    return {
      'withPay': false,
    };
  }
}
