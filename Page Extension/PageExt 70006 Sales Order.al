pageextension 70006 "Sales Order" extends "Sales Order"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("Dépôts actifs"; "Dépôts actifs")
            {

            }
        }

        modify("Sell-to Customer Name")
        {
            trigger OnAfterValidate()
            var
                customer: record Customer;
                userPar: record "User Setup";
            begin
                customer.Reset();
                customer.SetRange("No.", rec."Sell-to Customer No.");
                if customer.FindFirst() then begin
                    "Dépôts actifs" := customer."Dépôts";
                end;

                rec."Assigned User ID" := UserId;
                userPar.SetRange("User ID", UserId);
                if (userPar.FindFirst()) then
                    Rec."Salesperson Code" := userPar."Salespers./Purch. Code";
            end;
        }
        addafter(SalesLines)
        {
            group("Epargne client")
            {
                field(epargne; rec.epargne)
                {
                    trigger OnValidate()
                    var
                        ParVente: Record "Sales & Receivables Setup";
                    begin
                        ParVente.GET;
                        if rec.epargne then begin
                            if rec."Montant unitaire epargne" < ParVente."Montant epargne" then
                                Error('Le montant unitaire ne peut pas être inférieur au minimum');

                            if rec."Montant unitaire epargne" > ParVente."Montant epargne Max" then
                                Error('Le montant unitaire ne peut pas être supérieur au maximum');
                            setEpargne()
                        end
                        else
                            unsetEpargne();
                    end;
                }
                field("Type epargne"; rec."Type epargne")
                {
                    Caption = 'Unité';
                    Visible = false;
                    trigger OnValidate()
                    var
                        ParVente: Record "Sales & Receivables Setup";
                    begin
                        ParVente.GET;
                        if rec.epargne then begin
                            if rec."Montant unitaire epargne" < ParVente."Montant epargne" then
                                Error('Le montant unitaire ne peut pas être inférieur au minimum');

                            if rec."Montant unitaire epargne" > ParVente."Montant epargne Max" then
                                Error('Le montant unitaire ne peut pas être supérieur au maximum');
                            setEpargne();
                        end
                        else
                            unsetEpargne();
                    end;
                }
                field("Montant unitaire epargne"; rec."Montant unitaire epargne")
                {
                    trigger OnValidate()
                    var
                        ParVente: Record "Sales & Receivables Setup";
                    begin
                        ParVente.GET;
                        if rec.epargne then begin
                            if rec."Montant unitaire epargne" < ParVente."Montant epargne" then
                                Error('Le montant unitaire ne peut pas être inférieur au minimum');

                            if rec."Montant unitaire epargne" > ParVente."Montant epargne Max" then
                                Error('Le montant unitaire ne peut pas être supérieur au maximum');
                            setEpargne();
                        end
                        else
                            unsetEpargne();
                    end;
                }
                field("Montant epargne"; rec."Montant epargne")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnAfterGetRecord()
    var
        customer: record Customer;
    begin
        customer.Reset();
        customer.SetRange("No.", rec."Sell-to Customer No.");
        if customer.FindFirst() then begin
            "Dépôts actifs" := customer."Dépôts";
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        saleSetup: Record "Sales & Receivables Setup";
        customer: record Customer;
        userPar: record "User Setup";
    begin

        rec."Assigned User ID" := UserId;
        userPar.SetRange("User ID", UserId);
        if (userPar.FindFirst()) then
            Rec."Salesperson Code" := userPar."Salespers./Purch. Code";

        saleSetup.Get();
        rec."Montant unitaire epargne" := saleSetup."Montant epargne";
        rec."Type epargne" := saleSetup."Type epargne";
    end;

    trigger OnDeleteRecord(): Boolean
    var
        userSetup: Record 91;
    begin
        // if rec."Est Echantillone" then begin
        //     userSetup.Reset();
        //     userSetup.SetRange("User ID", UserId);
        //     userSetup.SetRange(delEchantillon, true);
        //     if NOT userSetup.FindFirst() then
        //         Error('Vous ne pouvez pas supprimer un echantillon douanier. Référez vous à la personne habilitée');
        // end;
    end;

    var
        "Dépôts actifs": Decimal;
        totalCarton: Decimal;
        totalQuantite: Decimal;



    local procedure setEpargne()
    var
        slines: Record "Sales Line";
        saleSetup: Record "Sales & Receivables Setup";
        customer: Record Customer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        depot: Record "Depôt";
        xdepot: Record "Depôt";
    begin
        totalCarton := 0;
        totalQuantite := 0;
        slines.Reset();
        slines.SetRange("Document No.", rec."No.");
        if slines.FindFirst() then begin
            repeat
                //slines."Statut Livraison" := rec."Statut Livraison";
                //GET nombre de carton pour la prime bonus
                // silue samuel 07/03/2025 totalCarton += slines."Carton effectif";
                totalQuantite += slines.Quantity;
            //if (rec."Statut Livraison" = rec."Statut Livraison"::) then
            //slines."Qté livrée" := slines."Carton effectif";

            //slines.Modify();
            until slines.Next = 0;
        end;


        saleSetup.Reset();
        customer.Reset();
        saleSetup.Get();
        xdepot.FindLast();
        customer.SetRange("No.", Rec."Sell-to Customer No.");
        if customer.FindFirst() then begin
            //if customer."do epargne" then begin

            if rec."Type epargne" = rec."Type epargne"::CARTON then begin
                //"reste à payer" += totalCarton * saleSetup."Montant epargne";
                rec."Montant epargne" := totalCarton * rec."Montant unitaire epargne";
            end else
                if rec."Type epargne" = rec."Type epargne"::POIDS then begin
                    //"reste à payer" += totalQuantite * saleSetup."Montant epargne";
                    rec."Montant epargne" := totalQuantite * rec."Montant unitaire epargne";
                end;
            //end;

        end;

    end;

    local procedure unsetEpargne()
    var
        //silue samuel 07/03/2025 slines: Record "Sales Invoice Line";
        saleSetup: Record "Sales & Receivables Setup";
        customer: Record Customer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        depot: Record "Depôt";
        xdepot: Record "Depôt";
        GA: page 9022;
    begin
        // silue samuel 07/03/2025totalCarton := 0;
        // totalQuantite := 0;
        // slines.Reset();
        // slines.SetRange("Document No.", rec."No.");
        // if slines.FindFirst() then begin
        //     repeat
        //         //slines."Statut Livraison" := rec."Statut Livraison";
        //         //GET nombre de carton pour la prime bonus
        //         totalCarton += slines."Carton effectif";
        //         totalQuantite += slines.Quantity;
        //     //if (rec."Statut Livraison" = rec."Statut Livraison"::"Payée totalement livré") then
        //     // slines."Qté livrée" := slines."Carton effectif";

        //     //slines.Modify();
        //     until slines.Next = 0;
        //fin silue samuel 07/03/2025 end;


        saleSetup.Reset();
        customer.Reset();
        saleSetup.Get();
        xdepot.FindLast();
        customer.SetRange("No.", Rec."Sell-to Customer No.");
        if customer.FindFirst() then begin
            //if customer."do epargne" then begin

            if rec."Type epargne" = rec."Type epargne"::CARTON then begin
                //"reste à payer" -= totalCarton * saleSetup."Montant epargne";
                rec."Montant epargne" := 0;


            end else
                if rec."Type epargne" = rec."Type epargne"::POIDS then begin
                    //"reste à payer" -= totalQuantite * saleSetup."Montant epargne";
                    rec."Montant epargne" := 0;
                end;
            //end;

        end;

    end;

}