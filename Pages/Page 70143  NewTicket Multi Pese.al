page 70143 "New Ticket Multi Pese"
{
    ApplicationArea = All;
    Caption = 'New Ticket Multi Pesée';
    PageType = Card;
    SourceTable = "Item Weigh Bridge";
    InsertAllowed = false;
    layout
    {

        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(MultiPese; rec.MultiPese)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin

                    end;
                }
                field("Nombre de planteurs"; Rec."Nombre de planteurs")
                {
                    ApplicationArea = All;
                    Enabled = REC.MultiPese;
                }

                field("Balance Code"; Rec."Balance Code")
                {
                    ToolTip = 'Specifies the value of the Balance Code field.', Comment = '%';
                    TableRelation = Balance.Code;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        // if rec.MultiPese=false then begin

                        // // end;
                        // if rec.MultiPese = true then begin
                        //     if Rec.AssistEdit_PointCaisses(xRec) then
                        //         CurrPage.Update();
                        // end else begin
                        //     if Rec.AssistEdit_PointCaisse(xRec) then
                        //         CurrPage.Update();
                        // end;


                    end;


                }
                //<<Fabrice Smart 05_03_25
                field("Client/Fournisseur"; rec."Client/Fournisseur")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        // if rec.MultiPese=false then begin

                        // // end;
                        // if rec.MultiPese = true then begin
                        //     if Rec.AssistEdit_PointCaisses(xRec) then
                        //         rec.RacineBalance := CopyStr(rec."Ticket Planteur", 1, 2);
                        //     CurrPage.Update();
                        // end else begin
                        //     if Rec.AssistEdit_PointCaisse(xRec) then
                        //         rec.RacineBalance := CopyStr(rec."Ticket Planteur", 1, 2);
                        //     CurrPage.Update();

                        // end;


                    end;

                }
                field(Description_Client_Fournisseur; Description_Client_Fournisseur)
                {
                    ApplicationArea = All;
                }

                field("Code article"; rec."Code article")
                {
                    ApplicationArea = All;
                    Caption = 'Produit';
                    TableRelation = Item;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        Item: Record Item;
                    begin
                        Item.SetRange("No.", rec."Code article");
                        if Item.FindFirst() then begin
                            rec."Désignation article" := Item.Description;
                        end;
                    end;
                }
                field("Désignation article"; REC."Désignation article")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(ORIGINE; rec.ORIGINE)
                {
                    Enabled = NOT REC.MultiPese;
                    ApplicationArea = All;
                    TableRelation = Origine.Origine;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        Origine: Record Origine;
                    begin
                        Origine.SetRange(Origine, rec.ORIGINE);
                        if Origine.FindFirst() then begin
                            REC."Item Origin" := Origine.Origine;
                            REC.Modify()
                        end;
                    end;
                }
                field("Type Vehicule"; REC."Type Vehicule")
                {
                    ApplicationArea = All;
                    TableRelation = "Type Vehicule"."Matricule Vehicule";
                }
                field("Vehicle Registration No."; "Vehicle Registration No.")
                {
                    ApplicationArea = All;
                    // TableRelation = Vendor.Matricule_Vehicule where("No." = const('FTR*'));
                    trigger OnValidate()
                    var
                        vendor: Record Vendor;
                    begin
                        vendor.SetRange(Matricule_Vehicule, rec."Vehicle Registration No.");
                        if vendor.FindFirst() then begin
                            rec.TestField("Vehicle Registration No.");
                            rec.validate("Code Transporteur", vendor."No.");
                        end else begin
                            Message('Le Matricule %1 n''est pas associé à un transporter veuillez Créer le transporteur', rec."Vehicle Registration No.");
                        end;
                    end;
                }
                field("Code Conducteur"; "Code Conducteur")
                {
                    ApplicationArea = All;

                }

                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                }
                field("Code Transporteur"; REC."Code Transporteur")
                {
                    ApplicationArea = All;
                    TableRelation = Vendor where("No." = const('FTR*'));
                    //         TableRelation = if ("Client/Fournisseur" = const("Client/Fournisseur"::" ")) Table_Vide
                    //         else
                    //         if
                    //  ("Client/Fournisseur" = const("Client/Fournisseur"::Client)) Vendor where("No." = const('FTR*'))
                    //         else
                    //         if ("Client/Fournisseur" = const("Client/Fournisseur"::Fournisseur)) Vendor where("No." = const('FTR*'))
                    //         else
                    //         if ("Client/Fournisseur" = const("Client/Fournisseur"::"Centre Logistique")) Vendor where("No." = const('FTR*'));


                }
                field("Nom Transporteur"; REC."Nom Transporteur")
                {
                    ApplicationArea = All;
                    // Editable = false;
                }
                field("Code Client"; REC."Code Client")
                {
                    TableRelation = customer;
                    //         ApplicationArea = All;
                    //         TableRelation = if ("Client/Fournisseur" = const("Client/Fournisseur"::" ")) Table_Vide
                    //         else
                    //         if
                    //  ("Client/Fournisseur" = const("Client/Fournisseur"::Client)) Customer
                    //         else
                    //         if ("Client/Fournisseur" = const("Client/Fournisseur"::Fournisseur)) Table_Vide
                    //         else
                    //         if ("Client/Fournisseur" = const("Client/Fournisseur"::"Centre Logistique")) Table_Vide;
                    // trigger OnValidate()
                    // var
                    //     myInt: Integer;
                    //     Vend: Record Vendor;
                    //     Custom: Record Customer;
                    // begin

                    //     Custom.SetRange("No.", rec."Code planteur");
                    //     if Custom.FindFirst() then begin
                    //         rec."Nom Client" := Custom.Name;
                    //     end;

                    // end;

                }
                field("Nom Client"; "Nom Client")
                {
                    ApplicationArea = All;
                }
                field("Centre Logistique"; "Centre Logistique")
                {
                    Visible = false;
                    ApplicationArea = All;
                    // TableRelation = if ("Client/Fournisseur" = const("Client/Fournisseur"::" ")) Table_Vide
                    // else
                    // if ("Client/Fournisseur" = const("Client/Fournisseur"::"Centre Logistique")) MagasinCentreLogistique."Centre logistique";
                    // trigger OnValidate()
                    // var
                    //     myInt: Integer;
                    //     Vend: Record Vendor;
                    //     Custom: Record Customer;
                    //     Centre_Logistique: Record MagasinCentreLogistique;
                    // begin
                    //     Centre_Logistique.SetRange("Centre Logistique", rec."Centre Logistique");
                    //     if Centre_Logistique.FindFirst() then begin
                    //         rec."Description Centre Logistique" := Centre_Logistique.Description;
                    //         REC.Modify()
                    //     end;
                    // end;
                }
                field(Matricule_Autre; REC.Matricule_Autre)
                {
                    ApplicationArea = All;
                    Caption = 'BERNE/CITERNE';
                }
                field("Description Centre Logistique"; "Description Centre Logistique")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Type opération"; Rec."Type opération")
                {


                    ToolTip = 'Specifies the value of the Type opération field.', Comment = '%';
                    TableRelation = "Type operation"."Type Operation";
                    Enabled = not rec.MultiPese;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        TypeOperation: Record "Type operation";
                    begin
                        TypeOperation.SetRange("Type Operation", rec."Type opération");
                        if TypeOperation.FindFirst() then begin
                            // rec."Type of Transportation" := 'RECEPTION';
                            rec."Type of Transportation" := TypeOperation.Mouvement;
                            REC.Modify();
                        end;
                    end;
                }
                field("Type of Transportation"; rec."Type of Transportation")
                {
                    ApplicationArea = All;
                }
                field("Code planteur"; "Code planteur")
                {
                    ApplicationArea = All;
                    TableRelation = Vendor where("No." = const('FAG*'));
                    Enabled = not REC.MultiPese;
                    //         TableRelation = if ("Client/Fournisseur" = const("Client/Fournisseur"::" ")) Table_Vide
                    //         else
                    //         if
                    //  ("Client/Fournisseur" = const("Client/Fournisseur"::Client)) Customer
                    //         else
                    //         if ("Client/Fournisseur" = const("Client/Fournisseur"::Fournisseur)) Vendor where("No." = const('FAG*'))
                    //         else
                    //         if ("Client/Fournisseur" = const("Client/Fournisseur"::"Centre Logistique")) Vendor;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        Vend: Record Vendor;
                        Custom: Record Customer;
                    begin

                        Vend.SetRange("No.", rec."Code planteur");
                        if Vend.FindFirst() then begin
                            rec."Nom planteur" := Vend.Name;
                        end;


                    end;
                    // Enabled = rec.MultiPese;
                    // TableRelation = Vendor;

                }
                field("Nom planteur"; Rec."Nom planteur")
                {
                    ToolTip = 'Specifies the value of the Nom planteur field.', Comment = '%';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Code magasin"; "Code magasin")
                {
                    ApplicationArea = All;
                }
                //<<Fabrice Smart 05_03_25
                field("Ticket Planteur"; Rec."Ticket Planteur")
                {
                    ToolTip = 'Specifies the value of the Ticket Planteur field.', Comment = '%';
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit_PointCaisse(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Item Origin"; Rec."Item Origin")
                {
                    ToolTip = 'Specifies the value of the Item Origin field.', Comment = '%';
                    Editable = false;
                }
                field(BonEnlevement; REC.BonEnlevement)
                {
                    ApplicationArea = All;
                }
                field("N° Commande PIC"; "N° Commande PIC")
                {
                    ApplicationArea = All;
                }
                field("Process Ticket"; rec."Process Ticket")
                {
                    Editable = false;
                }
                // field("Code planteur"; Rec."Code planteur")
                // {
                //     ToolTip = 'Specifies the value of the Code planteur field.', Comment = '%';
                // }
                field(CodeMultiPese; rec.CodeMultiPese)
                {
                    ApplicationArea = All;
                    Editable = false;

                }

            }
            group(Paiement)
            {
                Visible = false;
                field(Beneficiaire; rec.Beneficiaire)
                {
                    ApplicationArea = All;
                }
                field(NCNI; rec.NCNI)
                {
                    ApplicationArea = All;
                }
                field(Mode_Paiement; rec.Mode_Paiement)
                {
                    ApplicationArea = All;
                }
                field(Observation; rec.Observation)
                {
                    ApplicationArea = All;
                }

            }
            group(Poids)
            {
                Caption = 'Pesé';
                field("POIDS ENTREE"; Rec."POIDS ENTREE")
                {
                    ToolTip = 'Specifies the value of the POIDS ENTREE field.', Comment = '%';
                    // Editable = false;
                }
                field("POIDS SORTIE"; Rec."POIDS SORTIE")
                {
                    ToolTip = 'Specifies the value of the POIDS SORTIE field.', Comment = '%';
                    // Editable = false;
                    // Editable = false;
                }
                //<<Fabrice Smart 05_03_25
                field("POIDS NET"; rec."POIDS NET")
                {
                    ApplicationArea = All;
                    // Editable = false;
                    // Editable = false;
                }
                field("Weighing 1 Date"; REC."Weighing 1 Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    // Editable = false;
                }
                field("Weighing 2 Date"; REC."Weighing 2 Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    // Editable = false;
                }
                field("Weighing 1 Hour"; REC."Weighing 1 Hour")
                {
                    ApplicationArea = All;
                    Editable = false;
                    // Editable = false;
                }
                field("Weighing 2 Hour"; REC."Weighing 2 Hour")
                {
                    ApplicationArea = All;
                    Editable = false;
                    // Editable = false;
                }
                field("Date validation"; REC."Date validation")
                {
                    ApplicationArea = All;
                    Editable = false;
                    // Editable = false;
                }
                //<<Fabrice Smart 05_03_25
            }
            // part(MultiPeseSubForm; MultiPeseSubForm)
            // {
            //     SubPageLink = TICKET = field(TICKET), CodeIncrementAuto = field(CodeIncrementAuto);

            // }
        }


    }

    actions
    {
        area(processing)
        {
            action("CreateNew")
            {
                CaptionML = ENU = 'Read from Scale', FRA = 'Lire le poids';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    balance: Record Balance;
                    jObj: JsonObject;
                    jTok: JsonToken;
                begin
                    
                    rec.TestField("Client/Fournisseur");
                    balance.get(Rec."Balance Code");
                    jObj.ReadFrom(balance.PostJsonUsingSend());
                    jObj.Get('weight', jTok);
                    case Rec."Process Ticket" of
                        Rec."Process Ticket"::Create:
                            begin
                                
                                evaluate(Rec."POIDS ENTREE", jTok.AsValue().AsText());
                                Rec."Weighing 1 Date" := today();
                                Rec."Weighing 1 Hour" := Time();
        
                                //******Gestion de la source de numero
                                if rec.CodeMultiPese = '' then begin
                                    if Rec.AssistEdit_PointCaisses(xRec) then
                                        rec.RacineBalance := CopyStr(rec."Ticket Planteur", 1, 2);
                                    CurrPage.Update();
                                end;

                                // end else begin
                                //     if rec."Ticket Planteur" = '' then begin
                                //         if Rec.AssistEdit_PointCaisse(xRec) then
                                //             rec.RacineBalance := CopyStr(rec."Ticket Planteur", 1, 2);
                                //         CurrPage.Update();
                                //     end;
                                // end;
                                if rec."Ticket Planteur" = '' then begin
                                    if Rec.AssistEdit_PointCaisse(xRec) then
                                        rec.RacineBalance := CopyStr(rec."Ticket Planteur", 1, 2);
                                    CurrPage.Update();
                                end;

                                //******Gestion de la source de numéro
                            end;
                        Rec."Process Ticket"::Update:
                            begin
                                evaluate(Rec."POIDS SORTIE", jTok.AsValue().AsText());
                                Rec."Weighing 2 Date" := today();
                                Rec."Weighing 2 Hour" := Time();
                                // Rec."POIDS NET" := Rec."POIDS SORTIE" - Rec."POIDS ENTREE";
                                Rec."POIDS NET" := Abs(Rec."POIDS ENTREE" - Rec."POIDS SORTIE");
                            end;
                    end;
                    Rec.Modify();
                    CurrPage.Update(false);
                end;
            }
            action(Validation)
            {
                Caption = 'Valider le ticket';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Post;
                trigger OnAction()
                var
                    ItemWeight2: Record "Item Weigh Bridge";
                    ticket: Record "Item Weigh Bridge";
                begin
                    TestField(valide, false);
                    if ((rec."POIDS SORTIE" <= 0) or (rec."POIDS ENTREE" <= 0) or ((rec."POIDS SORTIE" <= 0) and (rec."POIDS ENTREE" <= 0))) then begin
                        Error('Le ticket %1 n''est pas valide', rec."Ticket Planteur");
                    end else begin
                        REC.valide := true;
                        rec."Date validation" := WorkDate();
                        rec.UserName := UserId();
                        Rec.Modify();
                        // Message('aa: %1', rec.UserName);
                        Commit();
                        // Message('Le ticket %1 créée le %2 a été validé avec succès', rec."Ticket Planteur", rec."Weighing 1 Date");//***FnGeek
                        Ticket.SetRange(TICKET, rec.TICKET);
                        ticket.SetRange("Row No.", rec."Row No.");
                        ticket.SetRange("Ticket Planteur", rec."Ticket Planteur");
                        ticket.SetRange(RowID, rec.RowID);
                        if ticket.FindFirst() then begin
                            // RunModal(Report::"Ticket de caisse", ticket)
                            Report.Run(Report::"Ticket de caisse", TRUE, false, ticket);
                        end;
                        rec.imprime := true;
                        REC.UserName := UserId;
                        REC.Modify()
                    end;
                end;
            }
        }


    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        myInt: Integer;
    begin
        // Message('wesh');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        // Message('New record');
        // rec.Insert();
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        rec.MultiPese := true;
        
    end;

    var
        PlanterCodeunit: Codeunit "Planter's Post";
}