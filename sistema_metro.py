import mysql.connector
from mysql.connector import Error
from datetime import datetime

def crear_conexion():
    try:
        conexion = mysql.connector.connect(
            host='localhost',          
            user='root',               
            password='perritofeliz12',    
            database='sistemametro'
        )
        
        if conexion.is_connected():
            print("=" * 60)
            print("Conexión exitosa a la base de datos SistemaMetro")
            print("=" * 60)
            return conexion
    
    except Error as e:
        print(f"Error al conectar a MySQL: {e}")
        return None

def llamar_procedimiento_insertar_usuario(conexion):
    try:
        cursor = conexion.cursor()
        
        # Datos del nuevo usuario
        cedula = 1012345678
        nombre = 'Laura'
        apellido = 'Montoya'
        direccion = 'Carrera 48 #30-15'
        telefono = '3145678901'
        estrato = 3
        fecha_nacimiento = '1991-06-20'
        
        print("\n" + "=" * 60)
        print("PROCEDIMIENTO 1: Insertar Usuario")
        print("=" * 60)
        print(f"Insertando usuario: {nombre} {apellido}")
        print(f"Cédula: {cedula}")
        
        # Llamar al procedimiento almacenado
        cursor.callproc('insertar_usuario', 
                       [cedula, nombre, apellido, direccion, telefono, estrato, fecha_nacimiento])
        
        # Obtener resultado
        for result in cursor.stored_results():
            resultado = result.fetchall()
            for fila in resultado:
                print(f"✓ {fila[0]}")
        
        conexion.commit()
        cursor.close()
        
    except Error as e:
        print(f"✗ Error al insertar usuario: {e}")

def llamar_procedimiento_recargar_civica(conexion):
    try:
        cursor = conexion.cursor()
        
        id_civica = 1
        monto_recarga = 50000
        
        print("\n" + "=" * 60)
        print("PROCEDIMIENTO 2: Recargar Tarjeta Cívica")
        print("=" * 60)
        print(f"Recargando tarjeta cívica ID: {id_civica}")
        print(f"Monto de recarga: ${monto_recarga:,}")
        
        # Llamar al procedimiento almacenado
        cursor.callproc('recargar_civica', [id_civica, monto_recarga])
        
        # Obtener resultado
        for result in cursor.stored_results():
            resultado = result.fetchall()
            for fila in resultado:
                print(f"✓ {fila[0]}")
        
        conexion.commit()
        cursor.close()
        
    except Error as e:
        print(f"✗ Error al recargar cívica: {e}")

def llamar_procedimiento_consultar_viajes(conexion):
    try:
        cursor = conexion.cursor()
        
        cedula_usuario = 1001234567
        
        print("\n" + "=" * 60)
        print("PROCEDIMIENTO 3: Consultar Viajes de Usuario")
        print("=" * 60)
        print(f"Consultando viajes del usuario con cédula: {cedula_usuario}")
        print("-" * 60)
        
        # Llamar al procedimiento almacenado
        cursor.callproc('consultar_viajes_usuario', [cedula_usuario])
        
        # Obtener resultados
        viajes_encontrados = False
        for result in cursor.stored_results():
            resultados = result.fetchall()
            if resultados:
                viajes_encontrados = True
                print(f"{'ID Viaje':<10} {'Tarifa':<10} {'Fecha y Hora':<20} {'Estación':<20} {'Saldo Actual':<15}")
                print("-" * 60)
                for fila in resultados:
                    id_viaje = fila[0]
                    tarifa = fila[1]
                    hora_acceso = fila[2]
                    nombre_estacion = fila[3]
                    saldo_actual = fila[5]
                    print(f"{id_viaje:<10} ${tarifa:<9,} {hora_acceso!s:<20} {nombre_estacion:<20} ${saldo_actual:,}")
        
        if not viajes_encontrados:
            print("No se encontraron viajes para este usuario")
        
        cursor.close()
        
    except Error as e:
        print(f"✗ Error al consultar viajes: {e}")

def llamar_procedimiento_info_linea(conexion):
    try:
        cursor = conexion.cursor()
        
        codigo_linea = 'LA'
        
        print("\n" + "=" * 60)
        print("PROCEDIMIENTO 4 (BONUS): Información de Línea con OUT")
        print("=" * 60)
        print(f"Consultando información de la línea: {codigo_linea}")
        print("-" * 60)
        
        # Preparar parámetros OUT
        args = [codigo_linea, 0, '', '']
        
        # Llamar al procedimiento almacenado
        resultado = cursor.callproc('info_linea_estaciones', args)
        
        # Los valores OUT están en las posiciones 1, 2 y 3 del resultado
        cantidad_estaciones = resultado[1]
        tipo_linea = resultado[2]
        codigo_retornado = resultado[3]
        
        print(f"Código de línea: {codigo_retornado}")
        print(f"Tipo de línea: {tipo_linea}")
        print(f"Cantidad de estaciones: {cantidad_estaciones}")
        print("-" * 60)
        
        # Obtener el resultado del SELECT
        for result in cursor.stored_results():
            resultados = result.fetchall()
            if resultados:
                print("\nDetalles de la línea:")
                for fila in resultados:
                    print(f"  • Código: {fila[0]}")
                    print(f"  • Color: {fila[1]}")
                    print(f"  • Longitud: {fila[2]} km")
                    print(f"  • Tipo: {fila[3]}")
        
        cursor.close()
        
    except Error as e:
        print(f"✗ Error al consultar información de línea: {e}")

def main():
    print("\n" + "=" * 60)
    print("SCRIPT PYTHON - SISTEMA METRO DE MEDELLÍN")
    print("=" * 60)
    
    # Crear conexión
    conexion = crear_conexion()
    
    if conexion:
        # Llamar los tres procedimientos almacenados
        llamar_procedimiento_insertar_usuario(conexion)
        llamar_procedimiento_recargar_civica(conexion)
        llamar_procedimiento_consultar_viajes(conexion)
        
        # Bonus: Procedimiento con parámetros OUT
        llamar_procedimiento_info_linea(conexion)
        
        # Cerrar conexión
        print("\n" + "=" * 60)
        print("Cerrando conexión a la base de datos...")
        conexion.close()
        print("✓ Conexión cerrada exitosamente")
        print("=" * 60 + "\n")
    else:
        print("No se pudo establecer conexión con la base de datos")

if __name__ == "__main__":
    main()