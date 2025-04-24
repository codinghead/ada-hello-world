with HAL; use HAL;
with HAL.GPIO;
with RP.GPIO; use RP.GPIO;
with Ada.Real_Time; use Ada.Real_Time;

procedure Main is
   LED : GPIO_Point := GPIO_17;

   procedure MsDelay (Ms : Natural) is
      Start : Time := Clock;
   begin
      loop
         exit when Clock - Start >= To_Time_Span (Duration (Ms) / 1000.0);
      end loop;
   end MsDelay;

begin
   Enable_GPIO_Clock;
   Configure (LED, Output);

   loop
      Set (LED);
      MsDelay (500);
      Clear (LED);
      MsDelay (500);
   end loop;
end Main;
