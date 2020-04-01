import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upi_india/upi_india.dart';
import 'package:covid_19_app/util/payments.dart';
import 'package:covid_19_app/util/custom_appbar.dart';

class PaymentsPage extends StatefulWidget {
  @override
  _PaymentsPageState createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  final RECEIVER_UPI_ID = "pmcares@sbi";
  final RECEIVER_NAME = "PM CARES";

  Future _transaction;

  Future<String> initiateTransaction(String app, String amt) async {
    final txnId = Utils.generateTxnID();
    UpiIndia upi = new UpiIndia(
      app: app,
      receiverUpiId: RECEIVER_UPI_ID,
      receiverName: RECEIVER_NAME,
      transactionRefId: txnId,
      transactionNote: 'Paying $amt for PM CARES FUND Txn ID: $txnId',
      amount: double.parse(amt),
    );

    String response = await upi.startTransaction();

    return response;
  }

  final amtController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    amtController.dispose();
    super.dispose();
  }

  void _checkValidation(BuildContext context, String appName) {
    if (amtController.text == "") {
      final snackBar = SnackBar(
        content: Text('Please enter your amount!'),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
    _transaction = initiateTransaction(appName, amtController.text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: customAppbar(title: "Payments"),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(30.0),
            padding: EdgeInsets.all(10.0),
            child: TextFormField(
              controller: amtController,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Builder(
                            builder: (context) => RaisedButton(
                                child: Text('BHIM UPI'),
                                onPressed: () {
                                  _checkValidation(
                                      context, UpiIndiaApps.BHIMUPI);
                                }),
                          ))),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Builder(
                        builder: (context) => RaisedButton(
                            child: Text('Google Pay'),
                            onPressed: () {
                              _checkValidation(context, UpiIndiaApps.GooglePay);
                            }),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Builder(
                        builder: (context) => RaisedButton(
                            child: Text('PhonePe'),
                            onPressed: () {
                              _checkValidation(context, UpiIndiaApps.PhonePe);
                            }),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Builder(
                        builder: (context) => RaisedButton(
                          child: Text('PayTM'),
                          onPressed: () {
                            _checkValidation(context, UpiIndiaApps.PayTM);
                          },
                        ),
                      ),
                    ),
                  )
                ],
              )),
          Expanded(
            flex: 2,
            child: FutureBuilder(
              future: _transaction,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.data == null)
                  return Text(' ');
                else {
                  switch (snapshot.data.toString()) {
                    case UpiIndiaResponseError.APP_NOT_INSTALLED:
                      return Text(
                        'App not installed.',
                      );
                      break;
                    case UpiIndiaResponseError.INVALID_PARAMETERS:
                      return Text(
                        'Requested payment is invalid.',
                      );
                      break;
                    case UpiIndiaResponseError.USER_CANCELLED:
                      return Text(
                        'It seems like you cancelled the transaction.',
                      );
                      break;
                    case UpiIndiaResponseError.NULL_RESPONSE:
                      return Text(
                        'No data received',
                      );
                      break;
                    default:
                      UpiIndiaResponse _upiResponse;
                      _upiResponse = UpiIndiaResponse(snapshot.data);
                      String txnId = _upiResponse.transactionId;
                      String resCode = _upiResponse.responseCode;
                      String txnRef = _upiResponse.transactionRefId;
                      String status = _upiResponse.status;
                      String approvalRef = _upiResponse.approvalRefNo;
                      return AlertDialog(
                        content: Column(
                          children: <Widget>[
                            Text('Transaction Id: $txnId'),
                            Text('Response Code: $resCode'),
                            Text('Reference Id: $txnRef'),
                            Text('Status: $status'),
                            Text('Approval No: $approvalRef'),
                          ],
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Dismiss'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
