with Interfaces.C;

procedure Ada_Blink_Demo is

   procedure GPIO_Set (Pin : Natural; On : Boolean) is
      package C renames Interfaces.C;
      use type C.int;

      function System (command : C.char_array) return C.int
        with Import, Convention => C;
      --  Import libc `system` function to execute a shell command

      Command : aliased constant C.char_array :=
        C.To_C ("gpioset 0" & Pin'Img & "=" & (if On then "1" else "0"));
      --  Create the command string with a format: gpioset 0 <pin>=<1|0>
   begin
      if System (Command) /= 0 then
         raise Program_Error with "gpioset failed";
      end if;
   end GPIO_Set;
begin
   loop
      GPIO_Set (17, True);
      delay 0.5;
      GPIO_Set (17, False);
      delay 0.5;
   end loop;
end Ada_Blink_Demo;
