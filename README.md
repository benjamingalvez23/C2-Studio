# C2 Studio.

Descripción: Esta aplicación está diseñada como una herramienta de apoyo para los estudiantes que cursan la asignatura de Cálculo II. Su objetivo principal es facilitar el aprendizaje de los contenidos del ramo, especialmente en los temas que suelen resultar más complejos una vez que se introduce el estudio de las integrales.

## Caracteristicas.

-

-

-

-

-



## Pila De Tecnologia.

**Client:** Flutter, Android.

## Diagrema De State.

```mermaid
stateDiagram-v2
    [*] --> SplashScreen
    SplashScreen --> Menu 

    Menu --> Home 
    Menu --> Temario 

    Home--> informacionadicional 
    informacionadicional  --> VerMas
    VerMas --> informacionadicional 
    
    Temario --> ListaUnidades
    ListaUnidades --> Unidad1
    ListaUnidades --> Unidad2
    ListaUnidades --> Unidad3
    
    Unidad1 --> ListaUnidades 
    Unidad2 --> ListaUnidades 
    Unidad3 --> ListaUnidades
    
    Unidad1 --> Teoria1 
    Unidad1 --> Ejercicios1 
    Teoria1 --> Unidad1
    Ejercicios1 --> Unidad1
    
    Unidad2 --> Teoria2 
    Unidad2 --> Ejercicios2 
    Teoria2 --> Unidad2
    Ejercicios2 --> Unidad2
    
    Unidad3 --> Teoria3 
    Unidad3 --> Ejercicios3 
    Teoria3 --> Unidad3
    Ejercicios3 --> Unidad3
```

This project is a starting point for a Flutter application.
A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
