pageextension 70172 "Item Lookup" extends "Item Lookup"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
        UserSetup: Record "User Setup";
    begin
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst() then begin
            if UserSetup.DescriotionCL = '' then begin
                Rec.SetFilter(CL, '=%1', '');
            end;
        end;
        REC.FILTERGROUP(2);
        REC.SetFilter(CL, ReturnUserGroupCode());
        REC.FILTERGROUP(0);
    end;

    procedure ReturnUserGroupCode(): Text[250]
    var
        UsrGroupCodeVar: Code[250];
        UserSetUp: Record "User Setup";
    begin

        CLEAR(UsrGroupCodeVar);
        UserSetUp.RESET;
        IF UserSetUp.FINDFIRST THEN
            REPEAT
                IF USERID = UserSetUp."User ID" THEN
                    UsrGroupCodeVar := UserSetUp.DescriotionCL;
            UNTIL UserSetUp.NEXT = 0;
        EXIT(UsrGroupCodeVar);
    end;

    var
        myInt: Integer;
}
