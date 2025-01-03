import 'package:crafty_bay/data/models/payment_method.dart';
import 'package:crafty_bay/presentation/state_holders/payment_method_list_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/payment_gateway_webview.dart';
import 'package:crafty_bay/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({super.key});

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {

  @override
  void initState() {
    super.initState();
    Get.find<PaymentMethodListController>().getPaymentMethodList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Details"),
      ),
      body: GetBuilder<PaymentMethodListController>(
        builder: (paymentMethodListController) {

          if (paymentMethodListController.inProgress) {
            return const CenteredCircularProgressIndicator();
          }

          if (paymentMethodListController.errorMessage != null) {
            return Center(
              child: Text(paymentMethodListController.errorMessage!),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  _buildPaySummaryRow(
                      title: 'Total:',
                      amount: "${paymentMethodListController.paymentMethodResponseData!.total}",
                  ),
                  _buildPaySummaryRow(
                    title: 'Vat:',
                    amount: "${paymentMethodListController.paymentMethodResponseData!.vat}",
                  ),
                  _buildPaySummaryRow(
                    title: 'Total payable:',
                    amount: "${paymentMethodListController.paymentMethodResponseData!.payable}",
                  ),
                  const SizedBox(height: 20),
                  ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: paymentMethodListController.paymentMethodResponseData!.paymentMethod?.length ?? 0,
                      separatorBuilder: (_,__){
                        return const SizedBox(height: 8);
                      },
                      itemBuilder: (context,index){
                        final PaymentMethod paymentMethodType =
                        paymentMethodListController.paymentMethodResponseData!.paymentMethod![index];

                        return ListTile(
                          onTap: (){
                            Get.to(()=> PaymentGatewayWebview(
                                 gatewayUrl: paymentMethodType.redirectGatewayURL! ,
                              ),
                            );
                          },
                          leading: Image.network(paymentMethodType.logo!),
                          title: Text(paymentMethodType.name!),
                          trailing: const Icon(Icons.arrow_forward_ios_outlined),
                        );
                      },

                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  Widget _buildPaySummaryRow({required String title,required String amount}) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xff34495e),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$$amount',
                style: const TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
            ],
      );
  }
}
