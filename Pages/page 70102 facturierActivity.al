page 70102 FacturierActivity
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = 70027;

    layout
    {
        area(Content)
        {
            cuegroup("Factures en attente de paiement")
            {

                // field(facture; rec.facture)
                // {
                //     ApplicationArea = all;

                // }

                field("Factures du jour"; rec."Factures du jour")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        factureJour: Record "Sales Invoice Header";

                    begin
                        // factureJour.SetFilter("Order Date", WorkDate);
                        factureJour.SetFilter("Order Date", '=%1', WorkDate);
                        //  factureJour.SetRange(Closed, false);

                        factureJour.SetRange(facturier, false);

                        factureJour.FindFirst();
                        Page.RunModal(Page::"Liste des factures facturier", factureJour);
                    end;
                }
                // field("Factures anterieures"; rec."Factures anterieures")
                // {
                //     ApplicationArea = All;
                //     DrillDown = true;
                //     trigger OnDrillDown()
                //     var
                //         factureJour: Record "Sales Invoice Header";
                //     begin
                //         factureJour.SetFilter("Order Date", '<%1', WorkDate);
                //         factureJour.SetRange(Closed, false);
                //         factureJour.SetRange(Closed, false);
                //         factureJour.SetRange(facturier, false);
                //         factureJour.FindFirst();
                //         Page.RunModal(Page::"Liste des factures facturier", factureJour);
                //     end;
                // }

            }


        }

    }

    trigger OnOpenPage()
    begin


        SetFilter("Date Filter", '=%1', WorkDate);
        SetFilter("date filter 2", '<%1', WorkDate);
        //     DrillDown = true;


        if not rec.get then begin

            Rec.Init();

            Rec.Insert();

        end;

    end;

}