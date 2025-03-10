report 70023 "Recu caisse"
{
    RDLCLayout = 'Reports\RDLC\Report 70000 Ticket de caisse.rdlc';
    Caption = 'Ticket de caisse';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Encaissement; Encaissement)
        {
            RequestFilterFields = "N°";

            column(No_Transaction; "N°")
            {

            }
            column(NbImpression1;NbImpression1)
            {
                
            }
            column(Code_caisse; "Code caisse")
            {

            }
            column(Client_No_; "N° client")
            {

            }
            column(Client_epargne; Client_epargne)
            {

            }
            column(Mode_reglement; "Mode de paiement")
            {

            }
            column(Sell_to_Customer_Name; "Nom client")
            {

            }
            column(Date; Date)
            {

            }
            column(Montant; Montant)
            {

            }
            column(Rendu; Monnaie)
            {

            }
            column(Reste; Reste)
            {

            }
            column(ticket; ticket)
            {

            }
            column(listing; listing)
            {
            }
            column(BL; BL)
            {

            }
            // silue samuel 07/03/2025 column(TVA; parcaisse."% TVA")
            // {

            // }
            // silue samuel 07/03/2025 column(AIRSI; parcaisse."% AIRSI")
            // {

            // }

            column(Epargne; Epargne)
            {

            }
            column("Sole_epargne"; "Solde epargne")
            {

            }

            column(printdate; printdate)
            {

            }

            dataitem("Sales Header"; 112)
            {
                DataItemLink = "No." = field("N° Commande");

                column(Order_Date; "Order Date")
                {

                }
                column(No_CMDE; "No.")
                {

                }
                column(Amount; Amount)
                {

                }

                column(Amount_Including_VAT; "Amount Including VAT")
                {

                }
                column(VAT_Base_Discount__; "VAT Base Discount %")
                {

                }
                column("Montant_payé"; ("Amount Including VAT" + timbre) - "Remaining Amount")
                {

                }
                column(Timbre; Timbre)
                {

                }
                dataitem("Sales Line"; 113)
                {
                    DataItemLink = "Document No." = field("No.");
                    column(No_; "No.")
                    {

                    }
                    // column(Carton_effectif; "Carton effectif")
                    // {

                    //silue samuel 07/03/2025 }
                    column(Description; Description)
                    {

                    }
                    column(Quantity__Base_; "Quantity")
                    {

                    }
                    column(Unit_Cost; "Unit Price")
                    {

                    }
                    column(Line_Amount; "Line Amount")
                    {

                    }

                    column(totalCartons; totalCartons)
                    {

                    }

                    column(totalC; totalC)
                    {

                    }
                    column(Line_No_; "Line No.")
                    {

                    }
                    column(UnitHt; UnitHt)
                    {

                    }
                    column(MontantHt; MontantHt)
                    {

                    }


                    //  silue samuel 07/03/2025 dataitem(pesee; Pesse)
                    // {
                    //     DataItemLink = "Document No." = field("Order No."), "Line No." = field("Line No."), "No." = field("No.");
                    //     DataItemTableView = where(Valid = Const(true));
                    //     column(Poids; Poids)
                    //     {

                    //     }
                    //     column(nombre; nombre)
                    //     {

                    //     }
                    //     column(Total; Total)
                    //     {

                    //     }
                    //     column(Line_No_P; "Line No.")
                    //     {

                    //     }

                    //     column(tour; tour)
                    //     {

                    //     }

                    //     column(UnitHtround; UnitHtround) { }

                    //     column(MontantHtround; MontantHtround) { }
                    // fin silue samuel 07/03/2025 }


                    trigger OnAfterGetRecord()
                    var
                        myInt: Integer;
                        compta: Record "General Ledger Setup";
                        ligne: Record 113;
                    begin
                        compta.Reset();
                        if compta.FindFirst() then begin
                            //  silue samuel 07/03/2025 AIRSI := 1 + compta."% AIRSI" / 100;
                        end;

                        // silue samuel 07/03/2025  UnitHt := "Sales Line"."Unit price" / AIRSI;
                        UnitHtround := Round(UnitHt, 0.01, '=');
                        MontantHtround := UnitHtround * "Sales Line"."Quantity";
                        // MontantHtround:=Round(MontantHt,0.01,'=');

                        nbr += 1;
                        if nbr = 1 then
                            cible := "Sales Line"."Line No.";

                        if "Sales Line"."Line No." = cible then
                            tour += 1;

                    end;
                }

            }

            trigger OnAfterGetRecord()
            var
                Cust: Record Customer;
                epargne: Record "Depôt";
                parcaisse: Record 98;
                // fin silue samuel 07/03/2025 salesInvLines: record "Sales Invoice Line";
                SalInvHeader: Record "Sales Invoice Header";
            begin
                printdate := Today;
                Cust.SetRange("No.", "N° client");
                epargne.SetRange("N° client", "N° client");
                epargne.SetRange(isBonus, false);
                epargne.SetRange(validated, true);
                epargne.CalcSums(epargne.Montant);
                Client_epargne := epargne.Montant;

                if Cust.FindFirst() then begin
                    "Nom client" := Cust.Name;
                    cust.CalcFields("Montant prime bonus");
                    "Solde epargne" := Cust."Montant prime bonus";
                end;

                //  silue samuel 07/03/2025 salesInvLines.Reset();
                // salesInvLines.SetRange("Document No.", "N° commande");
                // if salesInvLines.FindFirst() then begin
                //     repeat
                //         totalC += salesInvLines."Carton effectif";
                //     until salesInvLines.Next = 0;
                // fin silue samuel 07/03/2025 end;
                // SalInvHeader.SetRange("No.", "N° commande");
                // if SalInvHeader.FindFirst() then begin
                //     NbImpression1:=SalInvHeader.NbImpression;
                // end;

            end;


            trigger OnPreDataItem()
            var
            begin
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(ticket; "ticket")
                {
                    Caption = 'Imprimer le ticket';
                }
                field(listing; "listing")
                {

                    Caption = 'Imprimer le listing';
                }
                field(BL; "BL")
                {

                    Caption = 'Imprimer le Bon de livraison';
                }
            }
        }

        actions
        {
            area(processing)
            {

            }
        }
        trigger OnOpenPage()
        var
            myInt: Integer;
        begin
            "ticket" := true;
            "listing" := true;
            "BL" := true;
            parcaisse.GET;

        end;
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        parcaisse.GET;
        "ticket" := true;
        "listing" := true;
        "BL" := true;

    end;

    trigger OnPostReport()
    var
        expVEnr: Record 110;
        SalesHeader: Record 112;
        parcaisse: Record 98;

    begin
        parcaisse.GET;
    end;


    var
        parcaisse: Record 98;
        Client_epargne: Decimal;
        "Solde epargne": Decimal;
        totalCartons: Decimal;
        totalC: Decimal;
        "Nom client": Text[50];
        "ticket": Boolean;
        "listing": boolean;
        "BL": boolean;
        tour: Integer;
        cible: Integer;
        nbr: Integer;
        printdate: Date;
        AIRSI: Decimal;
        UnitHt: Decimal;
        MontantHt: Decimal;
        UnitHtround: Decimal;
        MontantHtround: Decimal;
        NbImpression1: Integer;


}