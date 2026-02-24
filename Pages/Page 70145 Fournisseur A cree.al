page 70145 "Fournisseur A cree"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Item Weigh Bridge";
    Caption = 'Fournisseur à créer';
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    // SourceTableView=where("Code planteur"=filter())

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code planteur"; rec."Code planteur")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        vendor: Record Vendor;
    begin
        if vendor.FindFirst() then begin
            rec.SetRange("Code planteur", '<>%1', vendor."No.");
            // if REC.FindFirst() then begin
                // repeat begin
                // Message('aaa: %1', rec."Code planteur");
                // end until REC.Next() = 0;
            // end;

        end;
        // end;
    end;

    var
        myInt: Integer;
}