page 70072 "Livraison card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Invoice Header";
    Caption = 'Livraison Payées non livrées';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                field("Sell-to Customer No."; "Sell-to Customer No.") { }
                field("Statut Livraison"; "Statut Livraison")
                {
                    Editable = false;
                }

            }
            part("Detail livraison"; "Detail livraison")
            {
                SubPageLink = "Document No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Mise a jour")
            {
                ApplicationArea = All;
                Caption = 'Rafraîchir';
                Promoted = true;
                PromotedCategory = Process;
                Image = Refresh;
                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
            }
            action(Livraison)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Delivery;
                Caption = 'Livraison totale';

                trigger OnAction()
                var
                    myInt: Integer;

                    SInvLines: record "Sales Invoice Line";

                    cardLivraison: Page 70072;
                    controleLivraison: Record "Controle Livraison";

                begin
                    if rec."Statut Livraison" = rec."Statut Livraison"::"Payée partiellement livré" then begin
                        Message('Cette operation est possible que pour les factures non partiellement livré');
                    end else
                        if Confirm('Vous allez effectuer une livraison complete de cette commande ?. Cette operation est irreversible !') then begin
                            SInvLines.SetRange("Document No.", rec."No.");

                            if SInvLines.FindFirst then begin
                                repeat begin

                                    controleLivraison.Reset();
                                    Clear(controleLivraison);
                                    //controleLivraison.Init();
                                    controleLivraison."No article" := SInvLines."No.";
                                    controleLivraison."No facture" := SInvLines."Document No.";
                                    controleLivraison."Qté livrée" := SInvLines."Carton effectif";
                                    controleLivraison."Date Livraison" := WorkDate();
                                    SInvLines."Date Livraison" := WorkDate();
                                    SInvLines."Qté livrée" := SInvLines."Carton effectif";
                                    SInvLines."Statut Livraison" := SInvLines."Statut Livraison"::"Payée totalement livré";
                                    //MEttre a jour le statut livraison a ameliorer
                                    controleLivraison.Insert();


                                    SInvLines.Modify();
                                end until SInvLines.Next = 0;
                            end;

                            Rec."Statut Livraison" := Rec."Statut Livraison"::"Payée totalement livré";
                            Rec.Modify();

                            Message('Livraison effectuée avec succes');
                            cardLivraison.Update();

                        end;
                end;

            }
        }
    }
    var
        myInt: Integer;
}