page 70074 "Modifier livraison"
{
    PageType = ReportProcessingOnly;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Invoice line";


    layout
    {
        area(Content)
        {
            group("Livraison")
            {

                field("Document No."; "Document No.") { Editable = false; }
                field("No."; rec."No.")
                {
                    Caption = 'Numero article';
                    TableRelation = "Sales Invoice Line"."No.";
                    Editable = false;
                }
                // silue samuel 07/03/2025 field("Carton effectif"; rec."Carton effectif")
                // {
                //     Caption = 'Nombre de carton';
                //     Editable = false;
                // }

                field("Nombre de carton livre"; rec."Qté livrée") { Editable = false; }

                field(Quantity; rec.Quantity)
                {
                    Editable = false;
                    Caption = 'Poids';
                }
                field("Qté livrée"; "Qté_livrée")
                {

                }
                field("Date Livraison"; "Date_Livraison")
                {

                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Valider)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        SInvLines: record 113;
        SHeader: record 112;
        total: Boolean;
        cardLivraison: Page 70072;
    begin
        if (CloseAction = CloseAction::OK) then begin
            if "Qté_livrée" <= 0 then begin
                Error('la quantité ne peut etre vide');
            end

            else begin
                controleLivraison."No article" := rec."No.";
                controleLivraison."No facture" := rec."Document No.";
                controleLivraison."Qté livrée" := "Qté_livrée";

                // silue samuel 07/03/2025 if rec."Carton effectif" < "Qté livrée" + "Qté_livrée" then begin
                //     Error('Vous allez livrer plus de carton que necessaire');
                // end
                //             else begin

                //                 if Format(Date_Livraison) = '' then begin
                //                     controleLivraison."Date Livraison" := WorkDate();
                //                 end else
                //                     controleLivraison."Date Livraison" := Date_Livraison;


                //                 if (rec."Qté livrée" + "Qté_livrée" >= "Carton effectif") then
                //                     "Statut Livraison" := "Statut Livraison"::"Payée totalement livré"
                //                 else
                //                     if (rec."Qté livrée" + "Qté_livrée" < "Carton effectif") then
                //                         "Statut Livraison" := "Statut Livraison"::"Payée partiellement livré";




                //                 controleLivraison.Insert();
                //                 Rec.Modify();
                //                 Message('Livraison ajouté');
                //                 SInvLines.Reset();
                //                 SHeader.Reset();
                //                 SInvLines.SetRange("Document No.", rec."Document No.");
                //                 SHeader.SetRange("No.", rec."Document No.");
                //                 if SInvLines.FindFirst() then begin
                //                     total := true;
                //                     repeat
                //                         if SInvLines."Statut Livraison" <> SInvLines."Statut Livraison"::"Payée totalement livré" then
                //                             total := false;
                //                     until SInvLines.Next = 0;
                //                     if SHeader.FindFirst() then begin
                //                         if total then begin
                //                             SHeader."Statut Livraison" := SHeader."Statut Livraison"::"Payée totalement livré";
                //                             SHeader.Modify();
                //                         end else begin
                //                             SHeader."Statut Livraison" := SHeader."Statut Livraison"::"Payée partiellement livré";
                //                             SHeader.Modify();
                //                         end;
                //                     end;
                //                 end;
                //                 cardLivraison.Update();

                //        fin silue samuel 07/03/2025     end;
            end;
        end;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin

        /* SalesivoiceLine.SetRange("No.", SalesivoiceLine."No.");
         SalesivoiceLine.FindSet();*/
        //rec.CalcFields("Qté livrée");

    end;





    var
        myInt: Integer;
        //  silue samuel 07/03/2025 SalesivoiceLine: Record "Sales Invoice Line";
        "Date_Livraison": Date;
        "Qté_livrée": Integer;
        controleLivraison: Record "Controle Livraison";
    //  Quantity: Decimal;
    // "Nombre de carton": Decimal;

}