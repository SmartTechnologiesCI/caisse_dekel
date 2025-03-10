pageextension 70004 "Psted Sles Invoice" extends 143
{
    layout
    {
        addfirst(Control1)
        {
            field(No_ordre; rec.No_ordre)
            {
                Visible = false;
            }
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("Remaining Amount")
        {
            CaptionML = ENU = 'Remaining amount', FRA = 'Reste à payer';
        }
        addafter("Remaining Amount")
        {
            field(MontPayé; "MontPayé")
            {
                CaptionML = ENU = 'Paid Amount', FRA = 'Montant payé';
            }
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("No. Printed")
        {
            Visible = false;
        }
        modify(Corrective)
        {
            Visible = false;

        }
        modify(Amount)
        {
            Visible = false;
        }
        addafter("MontPayé")
        {
            field("Statut Livraison"; rec."Statut Livraison")
            {

            }
        }
        addafter(Control1)
        {
            /*  field("Total Crédit client"; "Total Crédit client")
             {

             } */

            /* field("Total Reste a Payer"; "Total Reste a Payer")
             {

             }
             field(MontantTTC; MontantTTC)
             {
                 Caption = 'Total Montant TTC';
             }*/


        }

        modify("No.")
        {

            DrillDownPageId = 132;
            trigger OnDrillDown()
            var
                myInt: Integer;
            begin
                Page.Run(132, rec);
            end;
        }


    }

    actions
    {
        // Add changes to page actions here
        addafter(CorrectInvoice)
        {
            action("Annuler la facture")
            {
                Image = "Invoicing-Cancel";
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    CU: Codeunit 70002;
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    //silue samuel 07/03/2025 SalesInvoiceLine: Record "Sales Invoice Line";
                    // silue samuel 07/03/2025 SalesCrMemoLineTempory: Record "Sales Cr.Memo Line Tempory";
                    //silue samuel 07/03/2025 SalesCrMemoLineTempory2: Record "Sales Cr.Memo Line Tempory";
                    SaleLine: Record "Sales Line";
                    SaleLine2: Record "Sales Line";
                    // SalesInvoiceHeader: Record "Sales Invoice Header";//<<Entete Facture vente enregistré
                    // SalesInvoiceLine: Record "Sales Invoice Line";//<<Ligne facture vente enregistré
                    SalesShipmentHeader: Record "Sales Shipment Header";//<<Entete expéditions vente enregistrée
                    SalesShipmentLine: Record "Sales Shipment Line";//<<Ligne expédition vente enregistrée
                begin
                    CU.CorrectPostedSalesInvoice(rec);
                end;
            }
           

            action("SetToPaid")
            {

                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                Visible = (userIdnt = 'TULIPE');
                trigger OnAction()
                var
                    Sih: Record "Sales Invoice Header";
                    // silue samuel 07/03/2025 SalCrMemoLineTempory: Record "Sales Cr.Memo Line Tempory";
                begin
                    //  silue samuel 07/03/2025if not SalCrMemoLineTempory.IsEmpty then begin
                    //     SalCrMemoLineTempory.DeleteAll();
                    //     SalCrMemoLineTempory.Reset();
                    // silue samuel 07/03/2025 end;

                    sih.Reset();
                    sih.setRange("Statut Livraison", Sih."Statut Livraison"::"Payée partiellement livré");
                    sih.SetRange(Closed, true);
                    Sih.SetRange(Cancelled, false);
                    Sih.SetFilter("Document Date", '<%1', DMY2Date(01, 01, 2022));
                    if sih.FindFirst() then begin
                        repeat
                            sih."Statut Livraison" := sih."Statut Livraison"::"Payée totalement livré";
                            Sih.Modify();
                        until Sih.Next = 0;
                    end;
                end;
            }
        }
    }


    trigger OnOpenPage()
    var
        myInt: Integer;
        userPerso: Record "User Personalization";
        sivh: record "Sales Invoice Header";
        sivh2: record "Sales Invoice Header";
        parCompta: record 98;

    begin
        // "Total Crédit client" := 0;

        /*userPerso.SetRange("User ID", UserId);
        if userPerso.FindFirst() then begin
            if userPerso."Profile ID" = 'DIRECTEUR' then
                rec.SetFilter("Statut Livraison", '<>%1', rec."Statut Livraison"::"Non payée");
        end;
       */
        userIdnt := UserId;
        sivh.SetRange("Due Date", WorkDate());
        if sivh.FindFirst() then begin
            repeat
                // parCompta.Get();
                // sivh.No_ordre := parCompta."N° order";
                // sivh.Modify();
                // parCompta."N° order" += 1;
                // parCompta.Modify();

            until sivh.next = 0;
        end;
        sivh2.Reset();

        CurrPage.SetSelectionFilter(sivh2);
        if sivh2.FindFirst() then begin
            repeat
                sivh2.CalcFields("Amount Including VAT");
                sivh2.CalcFields("Remaining Amount");
                MontantTTC += sivh2."Amount Including VAT";
                "Total Reste a Payer" += sivh2."Remaining Amount";
            until sivh2.Next = 0
        end;


        rec.SetCurrentKey(No_ordre);
        rec.SetAscending(rec.No_ordre, false);

    end;

    trigger OnAftergetRecord()
    var
        myInt: Integer;
    begin
        rec.CalcFields("Amount Including VAT");
        rec.CalcFields("Remaining Amount");
        /*    if (rec.CreditP = true and rec.Closed = false) then begin
               "Total Crédit client" += rec."Remaining Amount";

           end; */


        MontPayé := rec."Amount Including VAT" - rec."Remaining Amount";
    end;

    var
        ordre: Integer;
        // "Total Crédit client": Decimal;
        "Total Reste a Payer": Decimal;
        MontantTTC: Decimal;
        MontPayé: Decimal;
        userIdnt: Code[50];
}