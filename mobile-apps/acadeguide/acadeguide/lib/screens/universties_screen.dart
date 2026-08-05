import 'package:acadeguide/providers/university_provider.dart';
import 'package:acadeguide/routes/app_router.dart';
import 'package:acadeguide/widgets/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class UniverstiesScreen extends ConsumerStatefulWidget {
  const UniverstiesScreen({super.key});

  @override
  ConsumerState<UniverstiesScreen> createState() => _UniverstiesScreenState();
}

class _UniverstiesScreenState extends ConsumerState<UniverstiesScreen> {
  final Decorations _decorations = Decorations();
  @override
  Widget build(BuildContext context) {
    // Fetch the list of universities from the provider
    var universities = ref.watch(universityNotifierProvider);

    return Animate(
      effects: [
        FadeEffect(duration: 300.ms),
        ScaleEffect(duration: 300.ms, begin: Offset(0.8, 0.8)),
      ],
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: _decorations.screenHeading('UNIVERSITIES')),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "S E A R C H",
                    hintStyle: TextStyle(
                        color: const Color.fromARGB(255, 61, 82, 175)),
                    border: const OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search,
                        color: const Color.fromARGB(255, 61, 82, 175)),
                  ),
                  onChanged: (value) {
                    ref
                        .read(universityNotifierProvider.notifier)
                        .searchUniversity(value);
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: universities.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.goNamed(AppRouter.uniDetails.name,
                            pathParameters: {'id': universities[index].uniID!});
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 8.0),
                        child: Card(
                          color: index % 2 == 0
                              ? const Color.fromARGB(255, 255, 255, 255)
                              : const Color.fromARGB(255, 255, 255, 255),
                          elevation: 1,
                          child: ListTile(
                            leading: SizedBox(
                                width: 75,
                                child: universities[index]
                                        .uniLogo!
                                        .endsWith('.svg')
                                    ? SvgPicture.asset(
                                        'assets/uniLogos/${universities[index].uniLogo}')
                                    : Image.asset(
                                        'assets/uniLogos/${universities[index].uniLogo}',
                                        fit: BoxFit.contain)),
                            title: Text(
                              universities[index].uniName ?? "No Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: index % 2 == 0
                                      ? const Color.fromARGB(255, 255, 127, 7)
                                      : const Color.fromARGB(255, 61, 82, 175),
                                  fontSize: 18),
                            ),
                            subtitle: Text(
                              universities[index].uniDescription ??
                                  "No Description Provided",
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
