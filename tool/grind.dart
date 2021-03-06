import 'package:grinder/grinder.dart';

main(final List<String> args) => grind(args);

@Task()
@Depends(analyze )
build() async {
    // Update Sample
    await runAsync("/Users/mikemitterer/.pub-cache/bin/buildSamples",arguments: [ "-u" ]);

    // Analyze
    analyze();

    // Build!
    await runAsync("/Users/mikemitterer/.pub-cache/bin/buildSamples",arguments: [ "-bc" ]);
}

@Task()
analyze() {
    final List<String> libs = [
        "lib/material_icons.dart"
    ];

    libs.forEach((final String lib) => Analyzer.analyze(lib));

    final List<String> samples = [
        "purple/web/main.dart"
    ];
    samples.forEach((final String sample ) {
        final String sampleFolder = sample.replaceAll("/web/main.dart","");
        run("tool/analyze-sample.sh",arguments: [ "samples/${sampleFolder}", "web/main.dart" ]);
    });

}

@Task()
clean() => defaultClean();
