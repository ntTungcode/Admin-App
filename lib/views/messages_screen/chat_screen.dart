import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/const/styles.dart';
import 'package:emart_seller/controllers/chats_controller.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/widgets/loading_indicator.dart';
import 'package:get/get.dart';

import '../widgets/text_style.dart';
import 'components/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: "${controller.friendName}".text.fontFamily(semibold).color(purpleColor).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                      controller: controller.msgController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: textfieldGrey,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: textfieldGrey,
                              )),
                          hintText: "Type a message....."),
                    )),
                IconButton(
                    onPressed: () {
                      controller.sendMsg(controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: const Icon(Icons.send, color: Colors.black)),
              ],
            )
                .box
                .height(80)
                .padding(const EdgeInsets.all(12))
                .margin(const EdgeInsets.only(bottom: 8))
                .make(),
            Obx(
                  () => controller.isLoading.value
                  ? Center(
                child: loadingIndicator(),
              )
                  : Expanded(
                  child: StreamBuilder(
                    stream: StoreServices.getChatMessages(
                        controller.chatDocId.toString()),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: loadingIndicator(),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: "Send a message..."
                              .text
                              .color(darkGrey)
                              .make(),
                        );
                      } else {
                        return ListView(
                          children: snapshot.data!.docs.mapIndexed((currentValue, index){
                            var data = snapshot.data!.docs[index];
                            return Align(
                                alignment:
                                data['uid'] == currentUser!.uid ? Alignment.centerRight : Alignment.bottomLeft,
                                child: chatBubble(data));
                          }).toList(),
                        );
                      }
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
