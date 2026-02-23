page 70145 "Fournisseur A cree"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Item Weigh Bridge";
    Caption = 'Fournisseur à créer';

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
        if vendor.FindSet() then begin
            rec.SetFilter("Code planteur", '<>%1', vendor."No.");
        end;
    end;

    var
        myInt: Integer;
}