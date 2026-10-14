class Imagen {
    const property image 
    const property position 

    method esAtravesable()

    method chocar(personaje){}

}   

class Pino inherits Imagen{

    override method esAtravesable(){
        return false 
    }
}

class Piedra inherits Imagen{

    override method esAtravesable(){
        return false 
    }


}

class Logo inherits Imagen{

    override method esAtravesable(){
        return false 
    }
}