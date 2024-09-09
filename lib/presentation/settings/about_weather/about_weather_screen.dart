import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_weather/ui/common_widgets/app_sizes.dart';

class AboutWeatherScreen extends ConsumerStatefulWidget {
  const AboutWeatherScreen({super.key});

  @override
  ConsumerState createState() => _AboutWeatherScreenState();
}

class _AboutWeatherScreenState extends ConsumerState<AboutWeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('About Weather'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'MUZE INNOVATION COMPANY LIMITED',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              '89 AIA Capital Center, Floor 25th, Ratchadapisek Road, Din Daeng, Bangkok 10400',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Sizes.p32),
            Text(
              'บริษัท มิวซ์ อินโนเวชั่น จำกัด',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              '89 อาคารเอไอเอ แคปปิตอล เซ็นเตอร์ ห้องเลขที่ 2501-2503 ชั้นที่ 25 ถนนรัชดาภิเษก แขวงดินแดง เขตดินแดง กรุงเทพมหานคร 10400',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
