class Unidad {
  final String titulo;
  final String descripcion;
  final List<String> temas;
  final String practica;
  
  Unidad(this.titulo, this.descripcion, this.temas, this.practica);
}

class InfoTemario {
  final String nombre;
  final String imagen;
  final Unidad unidad;
  InfoTemario(this.nombre, this.imagen, this.unidad);
}

final List<InfoTemario> carta = [
  InfoTemario(
    'Unidad 1',
    'assets/unidad1.jpg',
    Unidad(
      'Unidad I: Integrales Indefinidas',
      'Esta unidad se enfoca en el proceso inverso de la derivación, es decir, encontrar una función original a partir de su derivada. Es como "deshacer" una derivada.',
      [
        'Conceptos básicos: Qué es una integral indefinida y sus propiedades fundamentales',
        'Cambio de variable (sustitución): Para simplificar integrales complejas',
        'Integración por partes: Útil cuando tienes productos de funciones',
        'Fracciones parciales: Para integrar funciones racionales complejas',
        'Integrales trigonométricas: Especializadas en funciones seno, coseno, tangente, etc.',
        'Sustituciones especiales: Técnicas para casos específicos'
      ],
      'Resolverás problemas como encontrar la función velocidad si conoces la aceleración, o calcular la función de costo total conociendo el costo marginal.',
    ),
  ),
  
  InfoTemario(
    'Unidad 2',
    'assets/unidad2.jpg',
    Unidad(
      'Unidad II: Integral Definida',
      'Aquí pasas de las integrales "indefinidas" (sin límites) a las "definidas" (con límites específicos). Esta unidad conecta las integrales con aplicaciones geométricas y físicas concretas.',
      [
        'Integral de Riemann: El método matemático riguroso para calcular áreas bajo curvas',
        'Teoremas Fundamentales del Cálculo: Las reglas que conectan derivadas e integrales',
        'Cálculo de áreas entre curvas y bajo curvas',
        'Volúmenes de sólidos de revolución (como cilindros, conos, esferas)',
        'Integrales impropias: Para calcular áreas "infinitas" o con discontinuidades'
      ],
      'Calcularás el área de un lago irregular, el volumen de un tanque con forma especial, o la distancia recorrida por un objeto conociendo su velocidad en el tiempo.',
    ),
  ),
  
  InfoTemario(
    'Unidad 3',
    'assets/unidad3.jpg',
    Unidad(
      'Unidad III: Series',
      'Las series son sumas infinitas de términos. Esta unidad te enseña cuándo estas sumas infinitas tienen un valor finito (convergen) y cómo usarlas para aproximar funciones complejas.',
      [
        'Conceptos fundamentales: Qué es una serie y cuándo converge o diverge',
        'Series geométricas: Como 1 + 1/2 + 1/4 + 1/8 + ...',
        'Series telescópicas: Donde muchos términos se cancelan',
        'Serie-p: Una familia importante de series',
        'Criterios de convergencia: del término general, de comparación, del cociente, de la raíz, etc.',
        'Series de potencias: Series que dependen de una variable',
        'Series de Taylor y Maclaurin: Para aproximar funciones complicadas con polinomios'
      ],
      'Aproximarás funciones como e^x, sen(x), cos(x) usando polinomios simples, o determinarás si ciertos procesos físicos o económicos tienen límites finitos.',
    ),
  ),
];