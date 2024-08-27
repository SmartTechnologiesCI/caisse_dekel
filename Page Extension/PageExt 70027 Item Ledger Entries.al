pageextension 70027 "Item Ledger EntriesX" extends "Item Ledger Entries"
{
    layout
    {
        addafter("Document No.")
        {
            field("Document N°"; "Document N°")
            {
                Caption = 'N° Commande';
            }
        }
        addafter("Lot Qty."){
            field("Nombre de cartonc";rec."Nombre de cartonc"){
                ApplicationArea=All;
            }
            field("Diff Qty carton";"Diff Qty carton"){
                
            }
        }
    }

    actions
    {
        addafter("&Value Entries")
        {
            action("Remplir Ligne avoir")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    FillCreditMemo();
                end;
            }
        }
    }
    local procedure FillCreditMemo()
    var
        SalesShipmentLine: Record "Sales Shipment Line";//Lignes expéditiopn vente enregistré
        rec: Record "Item Ledger Entry";
    begin
        // rec.SetRange("Entry No.", SalesShipmentLine."Item Shpt. Entry No.");
        // rec.SetRange("Document Type", rec."Document Type"::"Sales Credit Memo");
        // if rec.FindFirst() then begin
        //     SalesShipmentLine.SetRange("Item Shpt. Entry No.", rec."Entry No.");
        //     if SalesShipmentLine.FindFirst() then begin
        //         repeat begin
        //             // Message('a:%1 b:%2 c:%3',);
        //             Message('yes');
        //         end until SalesShipmentLine.Next() = 0;
        //         // if rec."Document Type" = rec."Document Type"::"Sales Credit Memo" then begin

        //         // end;
        //     end;
        // end;
        SalesShipmentLine.SetRange("Item Shpt. Entry No.", rec."Entry No.");
        if SalesShipmentLine.FindFirst() then begin
            repeat begin
                Message('a:%1 b:%2 c:%3', rec."Entry No.", rec."Document Type", rec."Lot Qty.");
            end until SalesShipmentLine.Next() = 0;
            // if rec."Document Type" = rec."Document Type"::"Sales Credit Memo" then begin
            
            // end;
        end;
    end;

    var
        myInt: Integer;
}