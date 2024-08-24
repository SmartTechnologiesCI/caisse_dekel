codeunit 70004 "Test Cron"
{
    trigger OnRun()
    var
        Ctest: Record CronTest;
    begin
        if Ctest.GET then
            Ctest.DeleteAll()
        else begin

        end;
    end;

    var
        myInt: Integer;
}