
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:grd_proj/bloc/chat_bloc/bloc/chat_bloc.dart';
// import 'package:grd_proj/cache/cache_helper.dart';
// import 'package:grd_proj/service/signalR/signalr_service.dart';

// class ChatScreen extends StatelessWidget {
//   final TextEditingController _controller = TextEditingController();
//   final String user = "nada";

//   ChatScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) =>
//           ChatBloc(ChatSignalRService(token: CacheHelper.getData(key: 'token'), baseUrl: 'https://api.agrivisionlabs.tech/hubs/conversations'))
//             ..add(StartConnectionEvent()),
//       child: Scaffold(
//         appBar: AppBar(title: const Text("Chat")),
//         body: Column(
//           children: [
//             Expanded(
//               child: BlocBuilder<ChatBloc, ChatState>(
//                 builder: (context, state) {
//                   if (state is ChatMessageReceived) {
//                     return ListView.builder(
//                       itemCount: state.messages.length,
//                       itemBuilder: (context, index) {
//                         final msg = state.messages[index];
//                         return ListTile(
//                           title: Text(msg['user'] ?? ''),
//                           subtitle: Text(msg['message'] ?? ''),
//                         );
//                       },
//                     );
//                   }
//                   return const Center(child: CircularProgressIndicator());
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Expanded(child: TextField(controller: _controller)),
//                   IconButton(
//                     icon: const Icon(Icons.send),
//                     onPressed: () {
//                       final text = _controller.text;
//                       context
//                           .read<ChatBloc>()
//                           .add(SendMessageEvent(user, text));
//                       _controller.clear();
//                     },
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
