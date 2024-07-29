type LeagueProps = {
    name: string;
    withAccessCode: boolean;
    payment: Payment;
}

type Payment = {
    withPay: true;
    paymentLink: string;
} | {
    withPay: false;
}
// late String name;
//   late bool withLimit;
//   late int? limitNum;
//   late bool withPay;
//   late String? paymentLink;
//   late bool withAccessCode;