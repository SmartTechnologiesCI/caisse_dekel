page 70136 EnteteTransfertValde
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = EntetTransfert;
    ModifyAllowed = false;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    Caption = 'Transfet de fonds validés';


    layout
    {
        area(Content)
        {
            group(Général)
            {
                field(Caissier; Caissier)
                {
                    ApplicationArea = All;
                }
                field(Caisse; Caisse)
                {
                    ApplicationArea = All;
                }
                field(Solde; Solde)
                {
                    ApplicationArea = All;
                }
                field(NumDocExtern; NumDocExtern)
                {
                    ApplicationArea = All;
                }
                field(Observation; Observation)
                {
                    ApplicationArea = All;
                }
                field(DateTransFert; DateTransFert)
                {
                    ApplicationArea = All;
                }
            }
            part(LigneTransFertvalide; LigneTransFertvalide)
            {
                Caption = 'Lignes Transfert';
                ApplicationArea = All;
                SubPageLink = IDLIGNETRANSFERT = field(IDTRANSFERT), NumDocExtern = field(NumDocExtern);

            }

        }

    }

    actions
    {
        area(Processing)
        {
            action(Valider)
            {
                Caption = 'Valider transfert';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    Caisse: Record Caisse;
                    Transaction: Record Transactions;
                    LigneTransfert: Record LigneTransFert;
                begin
                    Transaction.Reset();
                    Transaction.Init();
                    LigneTransfert.SetFilter(IDLIGNETRANSFERT, '=%1', rec.IDTRANSFERT);
                    LigneTransfert.SetFilter(NumDocExtern, '=%1', rec.NumDocExtern);
                    if LigneTransfert.FindSet() then begin
                        repeat begin
                            Caisse.SetRange("Code caisse", rec.Caisse);
                            if Caisse.FindFirst() then begin
                                Transaction.Source := Transaction.Source::"Transfert de fond";
                                Transaction.Date := WorkDate();
                                Transaction.Heure := Time;
                                Transaction.Description := LigneTransfert.NumDocExtern + ' ' + Caisse."User ID" + ' ' + Format(LigneTransfert.Montant);
                                Transaction.Montant := LigneTransfert.Montant;
                                Transaction."Code caisse" := LigneTransfert.caisse;
                                Transaction."N° Document" := LigneTransfert.NumDocExtern;
                                Transaction."Mode de reglement" := Format(LigneTransfert.ModeReglement);
                                Transaction."user id" := Caisse."User ID";
                                Transaction."Montant NET" := LigneTransfert.Montant;
                                Transaction."Origine Operation" := LigneTransfert.caisse;
                                Transaction.DocExtern := LigneTransfert.NumDocExtern;
                                Transaction.Insert();
                            end;
                        end until LigneTransfert.Next() = 0;
                    end;

                    //Déduction de la caisse principal
                    Transaction.Reset();
                    Transaction.Init();
                    LigneTransfert.SetFilter(IDLIGNETRANSFERT, '=%1', rec.IDTRANSFERT);
                    LigneTransfert.SetFilter(NumDocExtern, '=%1', rec.NumDocExtern);
                    if LigneTransfert.FindSet() then begin
                        repeat begin
                            Caisse.SetRange("Code caisse", rec.Caisse);
                            if Caisse.FindFirst() then begin
                                Transaction.Source := Transaction.Source::"Transfert de fond";
                                Transaction.Date := WorkDate();
                                Transaction.Heure := Time;
                                Transaction.Description := LigneTransfert.NumDocExtern + ' ' + rec.Caissier + ' ' + Format(LigneTransfert.Montant);
                                Transaction.Montant := -LigneTransfert.Montant;
                                Transaction."Code caisse" := rec.Caisse;
                                Transaction."N° Document" := LigneTransfert.NumDocExtern;
                                Transaction."Mode de reglement" := Format(LigneTransfert.ModeReglement);
                                Transaction."user id" := rec.Caissier;
                                Transaction."Montant NET" := -LigneTransfert.Montant;
                                Transaction."Origine Operation" := LigneTransfert.caisse;
                                Transaction.DocExtern := LigneTransfert.NumDocExtern;
                                Transaction.Insert();
                            end;
                        end until LigneTransfert.Next() = 0;
                        rec.valide := true;
                        rec.Modify();
                    end;
                end;
            }
        }
    }

    var
        myInt: Integer;
}