

import 'dart:math';

List<Map<String, String>> palabrasAhorcadoConPistas = [
  {'palabra': 'PERRO', 'pista': 'Mascota común'},
  {'palabra': 'GATO', 'pista': 'Animal felino'},
  {'palabra': 'CASA', 'pista': 'Lugar de residencia'},
  {'palabra': 'COCHE', 'pista': 'Vehículo con ruedas'},
  {'palabra': 'MANZANA', 'pista': 'Fruta roja o verde'},
  {'palabra': 'PELOTA', 'pista': 'Objeto esférico usado en juegos'},
  {'palabra': 'JIRAFA', 'pista': 'Animal con cuello largo'},
  {'palabra': 'CIELO', 'pista': 'Lo que vemos sobre nosotros'},
  {'palabra': 'GUITARRA', 'pista': 'Instrumento musical con cuerdas'},
  {'palabra': 'LAPIZ', 'pista': 'Utensilio para escribir o dibujar'},
  {'palabra': 'SOL', 'pista': 'Estrella que ilumina el día'},
  {'palabra': 'PANTALLA', 'pista': 'Superficie que muestra imágenes'},
  {'palabra': 'TELEFONO', 'pista': 'Dispositivo para comunicarse'},
  {'palabra': 'FLORES', 'pista': 'Plantas con colores vistosos'},
  {'palabra': 'NARIZ', 'pista': 'Órgano en la cara'},
  {'palabra': 'RELOJ', 'pista': 'Marca el tiempo'},
  {'palabra': 'RIO', 'pista': 'Corriente de agua natural'},
  {'palabra': 'BICICLETA', 'pista': 'Medio de transporte con pedales'},
  {'palabra': 'GLOBO', 'pista': 'Objeto inflado con aire'},
  {'palabra': 'MESA', 'pista': 'Mueble para poner cosas'},
  {'palabra': 'VENTANA', 'pista': 'Abertura en la pared'},
  {'palabra': 'BOTA', 'pista': 'Calzado para el pie'},
  {'palabra': 'PLANTA', 'pista': 'Ser vivo con raíces'},
  {'palabra': 'CABALLO', 'pista': 'Animal de granja'},
  {'palabra': 'PEZ', 'pista': 'Animal acuático'},
  {'palabra': 'ARBOL', 'pista': 'Planta alta y frondosa'},
  {'palabra': 'PIZZA', 'pista': 'Comida italiana'},
  {'palabra': 'MONTAÑA', 'pista': 'Gran elevación del terreno'},
  {'palabra': 'PERA', 'pista': 'Fruta jugosa'},
  {'palabra': 'LUNA', 'pista': 'Satélite natural de la Tierra'},
  {'palabra': 'CANGURO', 'pista': 'Animal marsupial'},
  {'palabra': 'AVION', 'pista': 'Medio de transporte aéreo'},
  {'palabra': 'LIBRO', 'pista': 'Contiene información'},
  {'palabra': 'BANCO', 'pista': 'Lugar para sentarse'},
  {'palabra': 'MAPA', 'pista': 'Representación gráfica del territorio'},
  {'palabra': 'JABON', 'pista': 'Se usa para lavar'},
  {'palabra': 'JARDIN', 'pista': 'Área con plantas'},
  {'palabra': 'LUNES', 'pista': 'Primer día de la semana'},
  {'palabra': 'PANTALON', 'pista': 'Prenda de vestir'},
  {'palabra': 'ZANAHORIA', 'pista': 'Vegetal de color naranja'},
  {'palabra': 'RATON', 'pista': 'Pequeño roedor'},
  {'palabra': 'TELEVISION', 'pista': 'Aparato para ver programas'},
  {'palabra': 'TEATRO', 'pista': 'Lugar para espectáculos'},
  {'palabra': 'HOTEL', 'pista': 'Lugar para alojarse'},
  {'palabra': 'ALMOHADA', 'pista': 'Se usa para dormir'},
  {'palabra': 'CUADERNO', 'pista': 'Se usa para escribir'},
  {'palabra': 'BALON', 'pista': 'Esfera inflada'},
  {'palabra': 'PLAYA', 'pista': 'Lugar junto al mar'},
  {'palabra': 'VENTILADOR', 'pista': 'Se usa para refrescar'},
  {'palabra': 'SANDWICH', 'pista': 'Comida entre panes'},
  {'palabra': 'ELEFANTE', 'pista': 'Animal grande con trompa'},
  {'palabra': 'POLICIA', 'pista': 'Encargado de mantener el orden'},
  {'palabra': 'PANTALONES', 'pista': 'Prenda de vestir'},
  {'palabra': 'CAMISA', 'pista': 'Prenda de vestir superior'},
  {'palabra': 'CARTERA', 'pista': 'Se usa para llevar dinero'},
  {'palabra': 'NARANJA', 'pista': 'Fruta cítrica'},
  {'palabra': 'VINO', 'pista': 'Bebida alcohólica'},
  {'palabra': 'SILLA', 'pista': 'Asiento sin respaldo'},
  
];



//meotod para obtener una palabra aleatoria
Map<String, String> obtenerPalabraYPistaAleatoria() {
    Random random = Random();
    int indiceAleatorio = random.nextInt(palabrasAhorcadoConPistas.length);
    // ignore: avoid_print
    print('palabra ${palabrasAhorcadoConPistas[indiceAleatorio]}' );
    return palabrasAhorcadoConPistas[indiceAleatorio];
  }