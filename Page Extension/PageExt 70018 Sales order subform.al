pageextension 70018 "Sales order subform" extends 46
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
        salesHeader: Record "Sales Header";
    begin
        salesHeader.Reset();
        salesHeader.SetRange("No.", Rec."Document No.");
        if salesHeader.FindFirst() then begin

            // if salesHeader.Traitement <> salesHeader.Traitement::Ouvert then begin
            //     Rec.IsModify := true;
            // end;
        end;
    end;

    var
        myInt: Integer;
}