import direcciones.*
import estados.*
import nivelPersonajes.*
import cosasEntorno.*
import vida.*
import mapa.*
import administradorNiveles.*



class Personaje {

  var property position
  var property personaje
  var property nivel
  var property esAtravesable   = false
  var property estado 
  const estados
  var property direccionActual = abajo
  var vida                     = 6

  method vida() {
      return vida
  }

  method position() {
    return position
  }

  method normal(){
    return estados.normal()
  }

  method ataque(){
    return estados.ataque()
  }

  method danio(){
    return estados.danio()
  }

  method transformacion(){
    return estados.transformacion()
  }

  method muerte(){
    return estados.muerte()
  }

  method mover(direccion){
    if (estado.puedeMover()) {
      self.cambiarDireccion(direccion)
      const nuevaPosicion = direccion.siguiente(self.position())
      const objetos = game.getObjectsIn(nuevaPosicion)
      direccion.validarNuevaPosicion(self, nuevaPosicion, objetos)
    }
  }

  method image() {
    return estado.image(personaje, nivel, direccionActual.nombre())
  }

  method chocar(entidad){}

  method cambiarEstado(_estado){
    estado = _estado
    estado.reiniciarAnimacion()
  }

  method estaMuerto(){
    return vida <= 0
  }

  method validarMuerte(){
    if(self.estaMuerto()){
      self.accionar(self.muerte(), nivel)
    }
  }

  

  method vida(danio){
    vida -= danio
  }

  method perderEnergia(danio){
    self.vida(danio)
    self.validarMuerte()
  }

  method ejecutarAtaque(){}

  method cambiarDireccion(direccion){
    direccionActual = direccion
  }

  method atacar() {
    if (estado.puedeAtacar()) {
        self.accionar(self.ataque(), nivel)
    }
  }

  method recibirDanio() {
    self.accionar(self.danio(), nivel)
  }

  method accionar(_estado, nivelPersonaje){
    self.cambiarEstado(_estado)
    estado.ejecutar(self, nivelPersonaje)
  }

}


class Guerrero inherits Personaje {
  const elementosCrafts          = #{}
  var property maxSaludDeNivel   = 6


  method elementosCrafts(){
    return elementosCrafts
  }

  method agregarElementoCraft(elemento){
    elementosCrafts.add(elemento)
  }

  method sumarVida(_vida){
    vida += _vida
  }
  
  method fijarEnemigo(enemigo, casillero) {
    if (enemigo.position() == casillero) {
        enemigo.recibirDanio()
        nivel.perderEnergia(enemigo)
    }
  }

  method validarEnemigo() {
    const casilleroAtaque = direccionActual.siguiente(position)
    generadorGoblins.goblins().forEach({ enemigo => self.fijarEnemigo(enemigo, casilleroAtaque) })
  }

  override method ejecutarAtaque() {
    self.validarEnemigo()
  }


  //Interactua con objetos en la misma posicion que el personaje guerrero
  method interactuar() {
    const objetos = game.getObjectsIn(position)
    const objetosAtravesables = objetos.filter({ objeto => objeto.esAtravesable() })

    self.interactuarConItems(objetosAtravesables)
  }

  method interactuarConItems(objetos){
    if (!objetos.isEmpty()) {
        objetos.first().chocar(self)
    }
  }

  method aumentarSalud(suministroDeSalud){
      suministroDeSalud.aumentar(self)
  }

  method puedeAumentar(){
    return self.vida() < self.maxSaludDeNivel()
}

  method restaDeSalud(){
    return maxSaludDeNivel - vida
  }


  method transformar() {
    if(self.sePuedeTransformar()){
      self.accionar(self.transformacion(), nivel)
    }
  }

  method craftear(){
    elementosCrafts.clear()
  }

  method sePuedeTransformar(){
    return elementosCrafts.size() == 4
  }

  method subirNivel(nuevoNivel){
    nivel = nuevoNivel
    maxSaludDeNivel += 2
    vida = maxSaludDeNivel
    cc.agregarCorazon()
    cc.agregarCorazon()
  }

  method redibujar() {
    game.removeVisual(self)
    game.addVisual(self)
  }
}

class Goblin inherits Personaje {
  const enemigo = guerrero

  override method mover(direccion) {
    super(direccion)
    self.atacarGuerrero()
  }

  method atacarGuerrero() {
    const casilleroAtaque = direccionActual.siguiente(position)
    self.atacarEnemigo(casilleroAtaque)
  }

  method atacarEnemigo(casillero){
    if (enemigo.position() == casillero) {
        self.atacar()
    }
  }

  override method ejecutarAtaque() {
    enemigo.recibirDanio()
    nivel.perderEnergia(enemigo)
  }

  method perseguirGuerrero() {
    derecha.perseguirEnemigo(self, enemigo)
    izquierda.perseguirEnemigo(self, enemigo)
    arriba.perseguirEnemigo(self, enemigo)
    abajo.perseguirEnemigo(self, enemigo)
  }
}


class GeneradorGoblins inherits Generador {
  var property goblins = #{}
  var property cantidadMuertes = 0
  var property capacidad

  override method generar(cantidad, personaje) {
      if (cantidadMuertes < capacidad) {
          var posicion = pv.posicionRandom()
          const estadosGoblin = new EstadoGoblin()
          
          const nuevoGoblin = new Goblin(
              estados = estadosGoblin,
              estado = estadosGoblin.normal(),
              position = posicion,
              personaje = "goblin",
              nivel = self.nivelDelEnemigo()
              )
          goblins.add(nuevoGoblin)
          game.addVisual(nuevoGoblin)
      }
  }
  
  method eliminar(goblin) {
      cantidadMuertes += 1
      generadorDePociones.generar(cantidadMuertes, goblin)
      generadorCrafteo.generar(cantidadMuertes, goblin)
      goblins.remove(goblin)
  }

  method puedeAvanzarNivel() {
      return cantidadMuertes >= capacidad &&
        guerrero.nivel().nivel() >= 2
  }

  override method reiniciar() {
      goblins.forEach({ goblin =>
          game.removeVisual(goblin)
      })

      goblins.clear()
      cantidadMuertes = 0
  }

  method nivelDelEnemigo() {
    if (administradorNiveles.numeroNivelActual() == 1) {
        return nivelGoblin
    }
    else {
        return nivelGoblinCueva
    }
}
}

var generadorGoblins = new GeneradorGoblins(capacidad = 5)

var estadosGuerrero = new EstadoGuerrero()

var guerrero = new Guerrero(estados = estadosGuerrero, estado = estadosGuerrero.normal(), position = game.origin(), personaje = "guerrero", nivel = nivelGuerrero)