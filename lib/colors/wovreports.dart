class ReportTypes {
  static const explicitContent = ReportType('Contenido explícito');
  static const falseInformation = ReportType('Información falsa');
  static const hatePromoting = ReportType('Incitación al odio');

  static List<ReportType> getReportTypes() {
    var list = [
      explicitContent,
      falseInformation,
      hatePromoting
    ];
    return list;
  }
}

class ReportType {
  final String name;

  const ReportType(this.name);
}