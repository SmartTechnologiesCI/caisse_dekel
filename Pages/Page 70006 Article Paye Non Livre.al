page 70016 "Article PayeNonLivre List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Item;
    // SourceTableView = where("Statut Livraison" = const("Payée Non livré"), "Statut Livraison" = const("Payée partiellement livré"));
    //SourceTableView = where("Statut Livraison" = filter('=Payée Non livré|Payée partiellement livré'));
    //CalcFormula = exist("Sales Invoice Line" where("Statut Livraison" = filter('=Payée Non livré|Payée partiellement livré'), "No." = field("No.")));
    SourceTableView = where("Statut Livraison" = const(true), Blocked = const(false));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        //silue samuel 07/03/2025 sil: Record "Sales Invoice Line";

                    begin
                        // silue samuel 07/03/2025sil.SetRange("No.", Rec."No.");
                        //silue samuel 07/03/2025 sil.SetFilter("Posting Date", '>%1', DMY2Date(01, 07, 2021));
                        //silue samuel 07/03/2025 sil.FindSet();
                        //silue samuel 07/03/2025 Page.Run(70007, sil);
                    end;

                }
                field("Article"; rec.Description)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        //fin silue samuel 07/03/2025 sil: Record "Sales Invoice Line";

                    begin
                        // fin silue samuel 07/03/2025 sil.SetRange("No.", Rec."No.");
                        // fin silue samuel 07/03/2025 sil.SetFilter("Posting Date", '>%1', DMY2Date(01, 07, 2021));
                        //  fin silue samuel 07/03/2025 sil.Findset();

                        // Page.Run(70007, sil);
                    end;

                }

                field("Carton commande"; rec."Carton commande")
                {

                }



                field("Carton livre"; rec."Carton livre")
                {

                }
                field("Carton restant"; rec."Carton commande" - rec."Carton livre")
                {
                    Caption = 'Carton restant';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
    var
        // fin silue samuel 07/03/2025 salesInvoiceLine: Record "Sales Invoice Line";

    trigger OnOpenPage()
    var
        myInt: Integer;

    begin
        // fin silue samuel 07/03/2025 salesInvoiceLine.SetRange("No.", Rec."No.");

        // fin silue samuel 07/03/2025 salesInvoiceLine.FindSet();
    end;
}