page 70040 "Liste des prix à fixer"
{
    PageType = List;
    //ApplicationArea = All;
    // UsageCategory = Administration;
    SourceTable = "Purchase Header";
    Editable = false;
    //SourceTableView = where("Prix fixé" = const(false));
    layout
    {
        area(Content)
        {
            repeater(" ")
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        PHeader: Record "Purchase Header";
                        // silue samuel 07/03/2025 prixA: Record "Prix Articles";
                        //  silue samuel 07/03/2025 prixB: Record "Ligne Artcile prix";
                        PCompta: Record 98;
                    begin
                        PCompta.Reset();
                        PCompta.FindFirst();
                        PHeader.SetRange("No.", "No.");
                        //silue samuel 07/03/2025 prixA.SetRange("N° commande", "No.");
                        // if (NOT prixA.FindFirst()) then begin
                        //     prixA.Reset();
                        //     prixA."N° commande" := "No.";
                        //     prixA."Charges de fonctionnement unit" := PCompta."Charges de fonctionnement";
                        //     prixA."% Marge" := PCompta."% Marge";
                        //     prixA.Validate("Charges de fonctionnement unit");
                        //     prixA.Validate("% Marge");
                        //     prixA.Insert();
                        //     prixA.Validate("N° commande");
                        //     prixA.reset();
                        //     prixA.SetRange("N° commande", "No.");
                        //     prixA.FindFirst();
                        //     prixA.setOrder();
                        //     prixA.Modify();
                        //     // silue samuel 07/03/2025 prixB.Reset(); prixA.LoadLines(prixB);
                        //     CurrPage.Update();
                        //     Page.Run(Page::"Definition Prix Article", prixA);
                        // end
                        // else
                            // fin silue samuel 07/03/2025Page.Run(Page::"Definition Prix Article", prixA);
                    end;
                }
                field("Buy-from Vendor Name"; "Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        Vendor: Record "Vendor";
                    begin
                        Vendor.SetRange("No.", "Buy-from Vendor No.");
                        if (Vendor.FindFirst()) then begin
                            Page.Run(Page::"Vendor Card");
                        end;
                    end;
                }
                field(ETA; ETA)
                {
                    Caption = 'Date ETA';
                }
                field("Order Date"; "Order Date")
                {
                    ApplicationArea = All;

                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;

                }
                field("Currency Code"; "Currency Code")
                {
                    Caption = 'Code devise';
                    ApplicationArea = All;

                }
                field("Date de mise en vente"; "Date de mise en vente")
                {
                    ApplicationArea = All;
                }
                /*field("Prix fixé"; "Prix fixé")
                {
                    ApplicationArea = All;

                }*/

            }
            field(total; total)
            {
                Style = Strong;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Conteneurs en vente")
            {
                Image = CalculateShipment;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    conteneur: Record "Purchase Header";
                begin
                    // silue samuel 07/03/2025 conteneur.SetRange("Prix fixé", true);
                    conteneur.SetFilter(ETA, '>%1', DMY2Date(23, 03, 2021));
                    conteneur.SetRange(Vendu, false);
                    if conteneur.FindFirst() then
                        Page.RunModal(70064, conteneur);
                end;
            }
            action("Conteneurs Vendus")
            {
                Image = ValidateEmailLoggingSetup;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    conteneur: Record "Purchase Header";
                begin
                    // silue samuel 07/03/2025 conteneur.SetRange("Prix fixé", true);
                    conteneur.SetRange(Vendu, true);
                    conteneur.SetFilter(ETA, '>%1', DMY2Date(23, 03, 2021));
                    if conteneur.FindFirst() then
                        Page.RunModal(70065, conteneur);
                end;
            }
            action("Actualiser")
            {
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    conteneur: Record "Purchase Header";
                begin
                    CurrPage.Update();
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        PH: record "Purchase Header";
    begin
        PH.Reset();
        // silue samuel 07/03/2025 PH.SetRange("Prix fixé", false);
        PH.setFilter(ETA, '>%1', DMY2Date(23, 03, 2021));
        PH.SetRange("Fixation des prix", true);
        total := 0;
        if PH.FindFirst() then begin
            repeat
                PH.CalcFields(Amount);
                total += PH.Amount;
            until PH.Next = 0;
        end;

    end;

    var
        total: Decimal;
}