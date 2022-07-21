class Routine {
  final int id;
  final String title;
  final String description;
  final String Tag;
  var time; //= DateTime.now();
  var  frequency;
  var nextTime;


  Routine(
      this.id,
      this.title,
      this.description,
      this.Tag,
      this.frequency,
      this.nextTime) : time = DateTime.now();


  //Routine({required this.id, required this.title, required this.description});

  

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'description': description};
  }
}
