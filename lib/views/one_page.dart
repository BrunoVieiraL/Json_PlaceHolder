import 'package:flutter/material.dart';
import 'package:flutter_nv1/controllers/posts_controller.dart';

class OnePage extends StatefulWidget {
  const OnePage({Key? key}) : super(key: key);

  @override
  State<OnePage> createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  final PostController _controller = PostController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation:
                    Listenable.merge([_controller.posts, _controller.inLoader]),
                builder: (_, __) {
                  return _controller.inLoader.value
                      ? const CircularProgressIndicator()
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (_, index) => ListTile(
                            title: Text(
                              _controller.posts.value[index].title,
                            ),
                            subtitle: Text(_controller.posts.value[index].body),
                            leading: Text(
                                _controller.posts.value[index].id.toString()),
                          ),
                          itemCount: _controller.posts.value.length,
                        );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  _controller.callApi();
                },
                child: const Text(
                  'Botão',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
