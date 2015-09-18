DECLARE
   CURSOR c2 (idunico INTEGER)
   IS
      SELECT COUNT (*) AS cuenta
        FROM tabla
       WHERE cod_idunico = idunico;

   existe   INTEGER;
BEGIN
   FOR i IN 1 .. 2000
   LOOP
      OPEN c2 (i);

      FETCH c2
       INTO existe;

      EXIT WHEN c2%NOTFOUND;

      IF existe = 0
      THEN
         INSERT INTO tabla
                     (cod_idunico, aud_creador, aud_fcre, aud_usuario,
                      aud_fmon
                     )
              VALUES (i, 'usuario', SYSDATE, 'usuario',
                      SYSDATE
                     );
      END IF;

      CLOSE c2;
   END LOOP;

   COMMIT;
END;
