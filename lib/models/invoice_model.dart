



class InvoiceModel {
  const InvoiceModel ({
  required this.invoiceNumber,
  required this.invoiceDate,
  required this.invoiceAmount,
  required this.vehicleName,
  required this.vehicleModel,
  required this.currency,
  required this.invoiceUrl,
  });

  final String invoiceDate;
  final String invoiceNumber;
  final String invoiceAmount;
  final String vehicleName;
  final String vehicleModel;
  final String currency;
  final String invoiceUrl;
}