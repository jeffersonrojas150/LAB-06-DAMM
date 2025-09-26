import 'package:flutter/material.dart';

void main() {
  runApp(CalendarApp());
}

class CalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weekly Calendar UI',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: WeeklyCalendarScreen(),
    );
  }
}

class WeeklyCalendarScreen extends StatelessWidget {
  final double hourHeight = 60.0; // Altura en píxeles para 60 minutos
  final double dayColumnWidth = 50.0; // Ancho de la columna de horas
  final int startHour = 8; // La hora a la que empieza el calendario (8:00 AM)

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          // Mantenemos el color de fondo y la elevación
          backgroundColor: const Color.fromARGB(255, 75, 164, 80),
          elevation: 0,
          
          // 1. Icono de Menú ("Hamburguesa")
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
          
          // 2. Título complejo con varios elementos en una fila
          title: Row(
            mainAxisSize: MainAxisSize.min, // Para que la fila no ocupe más de lo necesario
            children: [
              Text('Calendario', style: TextStyle(color: Colors.white, fontSize: 22)),
              SizedBox(width: 32), // Espacio
              
              // Botón "Hoy"
              OutlinedButton(
                onPressed: () {},
                child: Text('Hoy', style: TextStyle(color: Colors.white)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white.withOpacity(0.8)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              SizedBox(width: 8),

              // Flechas de navegación
              IconButton(icon: Icon(Icons.chevron_left, color: Colors.white), onPressed: () {}),
              IconButton(icon: Icon(Icons.chevron_right, color: Colors.white), onPressed: () {}),
              SizedBox(width: 16),

              // Mes y Año
              Text('Septiembre 2025', style: TextStyle(color: Colors.white, fontSize: 18)),
            ],
          ),
          
          // Botones de acción a la derecha
          actions: [
            IconButton(icon: Icon(Icons.search, color: Colors.white), onPressed: () {}),
            IconButton(icon: Icon(Icons.help_outline, color: Colors.white), onPressed: () {}),
            IconButton(icon: Icon(Icons.settings_outlined, color: Colors.white), onPressed: () {}),
            SizedBox(width: 16),
            
            // Dropdown de vista "Semana"
            OutlinedButton.icon(
              onPressed: () {},
              icon: Text('Semana', style: TextStyle(color: Colors.white)),
              label: Icon(Icons.arrow_drop_down, color: Colors.white),
              style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white.withOpacity(0.8)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
            ),
            SizedBox(width: 16),
            
            IconButton(icon: Icon(Icons.apps, color: Colors.white), onPressed: () {}),

            // Icono de perfil
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: IconButton(
                icon: Icon(Icons.account_circle, size: 30, color: Colors.white),
                onPressed: () {},
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            _buildDaysHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    _buildGrid(),
                    _buildEvents(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

  Widget _buildDaysHeader() {
    final List<Map<String, String>> weekDays = [
      {'initial': 'L', 'number': '22'},
      {'initial': 'M', 'number': '23'},
      {'initial': 'M', 'number': '24'},
      {'initial': 'J', 'number': '25'},
      {'initial': 'V', 'number': '26'},
      {'initial': 'S', 'number': '27'},
      {'initial': 'D', 'number': '28'},
    ];

    return Container(
      padding: EdgeInsets.only(left: dayColumnWidth),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: weekDays.map((dayData) {
          final bool isToday = dayData['number'] == '22';
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dayData['initial']!,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4.0),
                  Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: isToday ? Colors.blue : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      dayData['number']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isToday ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildGrid() {
    final int totalHours = 15; 
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: dayColumnWidth,
          child: Column(
            children: List.generate(totalHours, (index) {
              return Container(
                height: hourHeight,
                child: Center(child: Text('${index + startHour}:00')),
              );
            }),
          ),
        ),
        Expanded(
          child: Column(
            children: List.generate(totalHours, (hourIndex) {
              return Container(
                height: hourHeight,
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey.shade200)),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
  double _getMinutesFromTime(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);
    return ((hour - startHour) * 60.0) + minutes;
  }

  Widget _buildEvent(String title, String startTime, String endTime, Color color) {
    final double top = _getMinutesFromTime(startTime);
    final double end = _getMinutesFromTime(endTime);
    final double height = end - top;

    if (height <= 0) return SizedBox.shrink();

    return Positioned(
      top: top,
      left: 4.0,
      right: 4.0,
      height: height,
      child: Container(
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: color.withOpacity(0.9),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 12),
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }

  Widget _buildEvents() {
    return Positioned.fill(
      left: dayColumnWidth,
      child: Row(
        children: [
          // Lunes
          _buildDayColumnWithEvents([
            _buildEvent('Integración de sistemas empresariales', "8:00", "10:30", Colors.orange),
            _buildEvent('Des. soluciones en la nube (TEO)', "10:30", "12:10", Colors.blue),
            _buildEvent('Diseño Proyectos Innovación (TEO)', "14:40", "15:30", Colors.green),
            _buildEvent('Diseño Proyectos Innovación (LAB)', "15:30", "17:10", Colors.green),
          ]),
          // Martes
          _buildDayColumnWithEvents([
            _buildEvent('Des. soluciones en la nube (LAB)', "9:40", "12:10", Colors.blue),
            _buildEvent('Prog. en móviles avanzado (TEO)', "13:00", "14:40", Colors.purple),
            _buildEvent('App móviles multiplataforma', "14:40", "16:20", Colors.teal),
          ]),
          // Miércoles
          _buildDayColumnWithEvents([
            _buildEvent('Prog. en móviles avanzado (LAB)', "8:00", "10:30", Colors.purple),
          ]),
          // Jueves
          _buildDayColumnWithEvents([]), // Sin clases
          // Viernes
          _buildDayColumnWithEvents([
            _buildEvent('Marketing y comercialización', "10:30", "12:10", Colors.redAccent),
            _buildEvent('Tutoría', "12:10", "13:00", Colors.grey),
          ]),
          // Sábado
          _buildDayColumnWithEvents([
            _buildEvent('Des. app web avanzado (LAB)', "8:00", "10:30", Colors.indigo),
            _buildEvent('Des. app web avanzado (TEO)', "10:30", "12:10", Colors.indigo),
          ]),
          // Domingo
          _buildDayColumnWithEvents([]), // Sin clases
        ],
      ),
    );
  }

  Widget _buildDayColumnWithEvents(List<Widget> events) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Stack(
          children: events,
        ),
      ),
    );
  }
}