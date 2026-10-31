import wollok.game.*
import inicializador.*


object botonStart {
  method image() = "boton_start.png"
  method position() = game.at(5, 5)
}

object botonControles {
  method image() = "boton_controles.png"
  method position() = game.at(5, 3)
}

object fondoMenu {
  method image() = "fondo_menu.png"
  method position() = game.origin()
}

object menu {
  method mostrar() {
    game.width(15)
    game.height(11)
    game.cellSize(50)
    game.title("Goblin Slayer")
  
    // El pasto queda como fondo permanente
    game.boardGround("fondo1.jpg")
  
    // La imagen del menú se dibuja por encima
    game.addVisual(fondoMenu)
  
    game.addVisual(botonStart)
    game.addVisual(botonControles)
  
    keyboard.enter().onPressDo({ menu.iniciarJuego() })
    keyboard.c().onPressDo({ menu.mostrarControles() })
  }

  method iniciarJuego() {
    game.removeVisual(fondoMenu)
    game.removeVisual(botonStart)
    game.removeVisual(botonControles)

    inicializador.preparar()
    inicializador.iniciarTicks()
  }

  method mostrarControles() {
    game.say(botonControles, "Flechas: mover | E: interactuar | T: transformar | Espacio: atacar")
  }
}
