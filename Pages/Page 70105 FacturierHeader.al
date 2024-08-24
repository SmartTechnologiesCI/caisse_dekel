page 70105 "facturier Entête"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = 112;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            part("Liste des articles"; 70031)
            {
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = suite;
            }


            group("Paiement")
            {
                group(Totaux)
                {

                    field(Amount; rec.Amount)
                    {
                        Caption = 'Montant HT';
                        ApplicationArea = All;
                        Editable = false;
                    }

                    field("Montant AIRSI"; Rec."Amount Including VAT" - Rec.Amount)
                    {
                        Caption = 'Montant AIRSI';
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Amount Including VAT"; rec."Amount Including VAT")
                    {
                        Caption = 'Montant TTC';
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }


                }




            }
        }

    }

    actions
    {
        area(Processing)
        {



            action("Facturier")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                Caption = 'Valider';
                trigger OnAction()
                var
                    myInt: Integer;
                    facture: Record "Sales Invoice Header";
                begin
                    if (Confirm('Avez vous terminer avec cette facture ?')) then begin
                        facture.Reset();
                        facture.SetRange("No.", "No.");
                        if facture.FindFirst() then begin
                            facture.facturier := true;
                            facture.Modify();
                        end;
                    end;
                    CurrPage.Close();
                end;
            }
            action("Afficher Totaux")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Totals;
                Visible = false;
                trigger OnAction()
                var
                    myInt: Integer;
                    facture: Record 113;

                    Montant_Ht: Decimal;
                    SommeTTC: Decimal;
                    Airsi: Decimal;
                    Montant_Ttc: Decimal;
                    timbre: Decimal;
                begin
                    facture.Reset();
                    facture.SetRange("Document No.", rec."No.");
                    if facture.FindFirst() then begin
                        repeat
                            Montant_Ht := Montant_Ht + Round((facture."Amount Including VAT" / 1.015), 1, '=');
                            SommeTTC := SommeTTC + facture."Amount Including VAT";

                        until facture.Next() = 0;
                    end;
                    timbre := rec.Timbre;
                    Montant_Ht := Round(Montant_Ht, 1, '=');
                    Airsi := SommeTTC - Montant_Ht;
                    Montant_Ttc := Montant_Ht + Airsi + timbre;


                    Message('Montant HT = %1 \ Airsi = %2 \ Timbre = %3 \ Montant TTC = %4', Montant_Ht, Airsi, timbre, Montant_Ttc);

                end;
            }
        }
    }




    trigger OnOpenPage()
    var

    begin


    end;










    var

    var
        // etat: Report 204;
        totalCarton: Decimal;
        totalQuantite: Decimal;
        "postLedger": Codeunit 70000;
        "Montant TVA": Decimal;
        "Montant Payé": Decimal;
        //"Montant epargne": Decimal;
        "Montant AIRSI": Decimal;
        "AmountandTimbre": Decimal;
        "tmbre": Decimal;
        "Mode de reglement": code[30];
        "Montant credit": Decimal;
        "Montant depot": Decimal;
        "Montant recu": Decimal;
        "Monnaie à rendre": Decimal;
        "reste à payer": Decimal;
        "Solde à payer total": Decimal;
        "Solde commande": Decimal;
        "Solde facture": Decimal;
        "dpt": Decimal;
        "validé": Boolean;
        //"epargne": Boolean;
        cutomer: record customer;
        "Caisse": Record caisse;
        "LineNo": Integer;
        "Hide": Boolean;
        "depotActive": Boolean;
        CurrentJnlTmplName: TextConst FRA = 'REGLEMENT';
        parCaisse: Record "Parametres caisse";
        isEch: Boolean;
    //  payerDepot: Boolean;


}







