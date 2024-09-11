pageextension 70032 "Transfer Order SubformExt" extends "Transfer Order Subform"
{
    layout
    {
        addbefore(Quantity)
        {
            field("Nombre de carton"; REC."Nombre de carton")
            {
                ApplicationArea = All;
                NotBlank = true;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    rec."Nombre de carton Ext" := rec."Nombre de carton";
                    rec.Validate(rec."Nombre de carton Ext", rec."Nombre de carton");

                end;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnClosePage()
    var
        myInt: Integer;
    begin
       
        if not rec.IsEmpty then begin
            rec.DeleteAll();
            rec.Reset();
        end;
    end;

    var
        myInt: Integer;
}